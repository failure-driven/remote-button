import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["The only button you will ever need", "Get yours today"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };