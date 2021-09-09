<script>
  import { getButton, pressButton } from "../services/button.js";
  // import ready from "../stores/";
  export let demoButtonId;

  let ready = 0;
  let time = 1000;
  // let primary = "btn btn-danger";
  // initial message
  let resetMessage = "almost time to boggie";

  let timer;
  let nestedTimer;

  const reflexTimeout = () => {
    ready = 0;
    resetMessage = `button reset -- Took to long :| `;
  };

  const resetButton = (message) => {
    ready = 0;
    resetMessage = `button reset -- ${message}`;
  };

  const changeReflexState = () => {
    // pressButton({ buttonId: demoButtonId })
    //   .then(() => getButton({ buttonId: demoButtonId }))
    //
    //
    //
    // TODO:
    // timer for reset sate || 3 clicks || long keydown ||
    //
    // readystate 2 time == work out the 'actual' reflex and dispay in ms
    // state?  Svelt stores || xState lib
    //

    if (ready === 0) {
      resetMessage = "reflex test started";
      ready = 1;
      // reflex waiting state fucntion ( split them up)
      timer = setTimeout(() => {
        ready = 2; // red

        // reset after 4 secs
        nestedTimer = setTimeout(reflexTimeout, 4000);
      }, time);
    } else if (ready === 1) {
      // kill timeouts
      //
      clearTimeout(timer);
      resetMessage = "error went to early";
      setTimeout(() => {
        resetButton("get movin");
      }, 3000);
    } else if (ready === 2) {
      clearTimeout(nestedTimer);
      // resetMessage = "Success :)";
      // TODO:
      // working out time here and pass to args of resetButton
      //
      resetButton("Success :) your time XXms -- Play again");
    }
  };
</script>

<button
  class="btn btn-primary my-1"
  on:click={changeReflexState}
  class:triggered={ready === 1}
  class:active={ready === 2}
  data-testid="button">button</button
>
<div data-testid="message">
  {resetMessage}
</div>

<style>
  .active {
    background-color: red !important;
  }
  .triggered {
    background-color: orange;
  }
</style>
