const imageInput = document.getElementById('image');
const contentTextarea = document.getElementById('content');

imageInput.addEventListener('change', function () {
    const file = this.files[0];
    if (file && file.type.startsWith('image/')) {
        const reader = new FileReader();

        reader.onload = function (e) {
            const imgTag = `<img src="${e.target.result}" alt="${file.name}" style="max-width:100%;">`;

            // 커서 위치에 이미지 삽입
            insertAtCursor(contentTextarea, imgTag);
        };

        reader.readAsDataURL(file);
    }
});

// 커서 위치에 문자열 삽입 함수
function insertAtCursor(textarea, text) {
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const before = textarea.value.substring(0, start);
    const after = textarea.value.substring(end);
    textarea.value = before + text + after;

    // 커서를 삽입된 텍스트 뒤로 이동
    textarea.selectionStart = textarea.selectionEnd = start + text.length;
    textarea.focus();
}
