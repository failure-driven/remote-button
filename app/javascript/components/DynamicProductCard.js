const DynamicProductCard = () => {
  // for movement animation to happen

  const card = document.querySelector(".card-esp32");
  const container = document.querySelector(".container-esp32");
  // specific element to animate
  const arduino = document.querySelector(".esp32 img");

  if (container) {
    // moving animation event
    container.addEventListener("mousemove", (e) => {
      // console.log(e.pageX);
      /* take window inner width/2 */
      const xAxis = (window.innerWidth / 2 - e.pageX) / 10;
      const yAxis = (window.innerWidth / 2 - e.pageY) / 10;
      card.style.transform = `rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
    });

    // when mouse is not over container, return to original positon:
    // Animate In
    container.addEventListener("mouseenter", () => {
      card.style.transition = "none";
      // Pop out
      arduino.style.transform = "translateZ(100px) rotateZ(10deg)"; // possible with preserve-3d
    });
    // Animate Out
    container.addEventListener("mouseleave", () => {
      card.style.transition = "all 0.5s ease";
      card.style.transform = "rotateY(0deg) rotateX(0deg)";
      // Pop back in
      arduino.style.transform = "translateZ(0px)"; // possible with
      arduino.style.transform = "translateZ(0px) rotateZ(0deg)";
    });
    /* in css file, added 3d effect to card: transform */
  }
};

export default DynamicProductCard;
