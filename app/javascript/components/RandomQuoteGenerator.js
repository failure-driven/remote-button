const randomQuote = () => {
  fetch("http://localhost:3000/quotes/sample")
    .then((result) => result.json())
    .then((jsonResult) => {
      document.getElementById("quote-text").innerHTML = jsonResult.text;
    });
};

const RandomQuoteGenerator = () => {
  const motivationButton = document.getElementById("motivation-button");
  if (motivationButton) {
    motivationButton.addEventListener("click", randomQuote);
  }
};

export default RandomQuoteGenerator;
