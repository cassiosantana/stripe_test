document.addEventListener('DOMContentLoaded', function () {
  let myButton = document.getElementById('myButton');
  myButton.addEventListener('click', function () {
    let xhr = new XMLHttpRequest();
    xhr.open('GET', '/example',true);
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4 && xhr.status === 200) {
        let response = JSON.parse(xhr.responseText);
        let myDiv = document.getElementById('myDiv');
        myDiv.textContent = response.message;
      }
    };
    xhr.send();
  });
});