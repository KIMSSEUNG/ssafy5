const editor = document.getElementById('editor');
const imageInput = document.getElementById('image');
const hiddenContent = document.getElementById('hiddenContent');
const imageFiles = []; // 서버에 보낼 이미지 목록

const maxImageCount = 5;

imageInput.addEventListener('change', function () {
  const file = this.files[0];
  if (!file) return;

  if (!isCursorInsideEditor()) {
    alert('커서를 글 내용 영역에 위치시켜 주세요.');
    imageInput.value = '';
    return;
  }

  const currentImageCount = editor.querySelectorAll('.image-block').length;
  if (currentImageCount >= maxImageCount) {
    alert(`이미지는 최대 ${maxImageCount}장까지만 추가할 수 있습니다.`);
    imageInput.value = '';
    return;
  }

  const reader = new FileReader();
  reader.onload = function (e) {
    const wrapper = document.createElement('div');
    wrapper.className = 'image-block';

    const img = document.createElement('img');
    img.src = e.target.result;
    img.className = 'inserted-img';
    img.draggable = false;

    img.addEventListener('click', function () {
      const confirmDelete = confirm('이 이미지를 삭제하시겠습니까?');
      if (confirmDelete) {
        const idx = imageFiles.indexOf(file);
        if (idx !== -1) {
          imageFiles.splice(idx, 1);
        }
        wrapper.remove();
      }
    });

    wrapper.appendChild(img);

    // 커서 위치에 삽입
    editor.focus();
    const selection = window.getSelection();
    if (!selection.rangeCount) return;
    const range = selection.getRangeAt(0);
    range.deleteContents();

    range.insertNode(document.createElement('br'));
    range.insertNode(wrapper);
    range.insertNode(document.createElement('br'));

    range.setStartAfter(wrapper);
    range.collapse(true);
    selection.removeAllRanges();
    selection.addRange(range);

    imageFiles.push(file); // 파일 저장
    imageInput.value = '';
  };

  reader.readAsDataURL(file);
});

function isCursorInsideEditor() {
  const selection = window.getSelection();
  if (!selection.rangeCount) return false;
  const range = selection.getRangeAt(0);
  return editor.contains(range.commonAncestorContainer);
}

document.querySelector('form').addEventListener('submit', function (e) {
  e.preventDefault(); // 기본 제출 막기

  const formData = new FormData();
  const title = document.getElementById('title').value;
  const contentHtml = editor.innerHTML;

  formData.append('title', title);
  formData.append('content', contentHtml);

  imageFiles.forEach(file => {
    formData.append('images', file); // 복수 업로드
  });

  fetch('/board/write', {
    method: 'POST',
    body: formData
  }).then(res => {
    if (res.ok) {
      alert('업로드 성공!');
      window.location.href = '/board';
    } else {
      alert('업로드 실패!');
    }
  }).catch(err => {
    alert('서버 오류: ' + err.message);
  });
});