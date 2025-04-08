const dragOverlay = document.querySelector('.drag-overlay');

// ⭐ 드래그 오버레이 표시
editor.addEventListener('dragover', function (e) {
  e.preventDefault();
  editor.classList.add('dragover');
  dragOverlay.style.display = 'block';
});

// ⭐ 드래그 나감
editor.addEventListener('dragleave', function (e) {
  e.preventDefault();
  editor.classList.remove('dragover');
  dragOverlay.style.display = 'none';
});

// ⭐ 드롭 시 이미지 삽입
editor.addEventListener('drop', function (e) {
  e.preventDefault();
  editor.classList.remove('dragover');
  dragOverlay.style.display = 'none';

  const file = e.dataTransfer.files[0];
  if (!file || !file.type.startsWith('image/')) return;

  const currentImageCount = editor.querySelectorAll('.image-block').length;
  if (currentImageCount >= maxImageCount) {
    alert(`이미지는 최대 ${maxImageCount}장까지만 추가할 수 있습니다.`);
    return;
  }

  const wrapper = document.createElement('div');
  wrapper.className = 'image-block';

  const imageIndex = imageFiles.length;
  const token = `__IMAGE_${imageIndex}__`;
  wrapper.setAttribute('data-token', token);

  const img = document.createElement('img');
  img.src = URL.createObjectURL(file);
  img.className = 'inserted-img';
  img.draggable = false;

  img.addEventListener('click', function () {
    const confirmDelete = confirm('이 이미지를 삭제하시겠습니까?');
    if (confirmDelete) {
      const idx = imageFiles.indexOf(file);
      if (idx !== -1) imageFiles.splice(idx, 1);
      wrapper.remove();
    }
  });

  wrapper.appendChild(img);

  const brBefore = document.createElement('br');
  const brAfter = document.createElement('br');

  let range = getDropRange(e);
  // 드롭 위치를 제대로 못 찾으면 맨 끝으로
  if (!range || !editor.contains(range.commonAncestorContainer)) {
    range = document.createRange();
    range.selectNodeContents(editor);
    range.collapse(false);
  }

  range.deleteContents();
  range.insertNode(brAfter);
  range.insertNode(wrapper);
  range.insertNode(brBefore);

  const sel = window.getSelection();
  sel.removeAllRanges();
  const newRange = document.createRange();
  newRange.setStartAfter(brAfter);
  newRange.collapse(true);
  sel.addRange(newRange);

  imageFiles.push(file);
});

// ✨ 커서 위치 계산 함수
function getDropRange(e) {
  if (document.caretRangeFromPoint) {
    return document.caretRangeFromPoint(e.clientX, e.clientY);
  } else if (document.caretPositionFromPoint) {
    const pos = document.caretPositionFromPoint(e.clientX, e.clientY);
    const range = document.createRange();
    range.setStart(pos.offsetNode, pos.offset);
    return range;
  }
  return null;
}
