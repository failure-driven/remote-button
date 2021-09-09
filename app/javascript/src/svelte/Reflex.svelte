<script>
  import { getButton, pressButton } from "../services/button.js";
  // import ready from "../stores/";
  export let demoButtonId;

  // initial message / state
  let resetMessage = "almost time to boggie";
  let ready = 0;

  // timer vars
  let time = 1000;
  let timer;
  let nestedTimer;
  let timerRunning = false;
  let startTime, endTime;

  // login functions
  const reflexTimeout = () => {
    ready = 0;
    resetMessage = `button reset -- Took to long :| `;
    timerRunning = false;
  };

  const resetButton = (message) => {
    ready = 0;
    resetMessage = `button reset -- ${message}`;
  };

  const reflextTimerBase = (time) => {
    // let startTime, endTime

    // console.log(startTime);
    if (timerRunning) {
      // set finish time
      endTime = time;
      // get starttime
      let result = startTime - endTime;
      timerRunning = false;

      var seconds = result * -1;
      console.log(seconds + " milli seconds");
      return seconds;
    } else {
      //
      timerRunning = true;
      startTime = time;
    }
  };

  const changeReflexState = () => {
    // pressButton({ buttonId: demoButtonId })
    //   .then(() => getButton({ buttonId: demoButtonId }))

    // TODO:
    // state?  Svelt stores || xState lib

    if (ready === 0) {
      resetMessage = "  Wait for RED...";
      ready = 1;

      timer = setTimeout(() => {
        ready = 2; // red
        // timer starts here
        reflextTimerBase(new Date());
        //
        resetMessage = "I'm Red CLICK ME !!";
        // reset after 4 secs
        nestedTimer = setTimeout(reflexTimeout, 4000);
      }, time);
    } else if (ready === 1) {
      // kill timeouts
      //
      clearTimeout(timer);
      resetMessage = "error went to early";
      timerRunning = false;
      setTimeout(() => {
        resetButton("get movin");
      }, 3000);
    } else if (ready === 2) {
      clearTimeout(nestedTimer);
      // end timer HERE
      //
      let result = reflextTimerBase(new Date());
      //
      resetButton(`Success :) your time ${result} milli seconds`);
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
