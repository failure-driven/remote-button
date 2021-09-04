import Typed from "typed.js";

const DynamicBannerText = () => {
  /* not sure what we need to use the typed variable for but
  ESLint does not like calling new Typed without setting a variable */
  /* eslint-disable no-unused-vars */
  const typed = new Typed("#banner-typed-text", {
    strings: ["The only button you will ever need", "Get yours today"],
    typeSpeed: 50,
    loop: true,
  });
};

export default DynamicBannerText;
