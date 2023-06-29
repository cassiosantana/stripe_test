document.addEventListener('DOMContentLoaded', function () {
  let currentIndex = 0;
  let paragraphCount = 0;
  const button = document.getElementById('my-button');
  const colors = ['blue', 'red', 'green'];
  const titles = ['Title 1', 'Title 2', 'Title 3'];
  const totalOptions = colors.length;

  let element = document.getElementById('div-nova');

  button.addEventListener('click', function () {
    if (currentIndex === totalOptions) {
      currentIndex = 0;
    }

    const newTitle = document.createElement('h1');
    const newParagraph = document.createElement('p');

    newTitle.innerHTML = titles[currentIndex];
    element.appendChild(newTitle);
    newTitle.style.color = colors[currentIndex];

    newParagraph.innerHTML = `Paragraph ${paragraphCount + 1}`;
    element.appendChild(newParagraph);

    currentIndex++;
    paragraphCount++;

    let newButton = document.createElement('button');
    newButton.innerHTML = 'Remove elements';
    element.appendChild(newButton);

    newButton.addEventListener('click', function () {
      element.removeChild(newTitle);
      element.removeChild(newParagraph);
      element.removeChild(newButton);
    });
  });
});

// criando uma requisicao ajax

// instancia do objeto XMLHttpRequest
let xhr = new XMLHttpRequest();

// configurando a requisicao
xhr.open('GET', 'url-da-requisicao', true);

// definindo o retorno da requisicao
xhr.onreadystatechange = function () {
  if (xhr.readyState === 4 && xhr.status === 200) {
    // manipular dos dados de resposta aqui
  }
};

// enviando a requisicao
xhr.send();