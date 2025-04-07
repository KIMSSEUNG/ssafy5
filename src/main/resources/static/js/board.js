const editor = document.getElementById('editor');
const imageInput = document.getElementById('image');
const hiddenContent = document.getElementById('hiddenContent');

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
    alert(`이미지는 최대 ${maxImageCount}장까지만 추가할 수 있습니다. 사진을 클릭해서 필요없는 사진을 제거하세요.`);
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

    // 이미지 클릭 시 삭제 여부 확인
    img.addEventListener('click', function () {
      const confirmDelete = confirm('이 이미지를 삭제하시겠습니까?');
      if (confirmDelete) {
        wrapper.remove();
      }
    });

    wrapper.appendChild(img);

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

// 최종 제출 시 내용 담기
document.querySelector('form').addEventListener('submit', function () {
  hiddenContent.value = editor.innerHTML;
});
