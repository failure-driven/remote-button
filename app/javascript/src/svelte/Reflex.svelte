<script>
  export let demoButtonId;

  const timer = {
    duration: 5000, // TODO: should come from server/configuration
    // elapsed: 0, // TODO: in future elapsed would also be tracked on server?
    ready: 0, // TODO: change these to worded states
    timerRunning: false,
    reflexStartTime: 0,
    reflexEndTime: 0,
    reflexStartDelay: 3000,
    reflexStart: undefined, // this is a function
    reflexStartReset: undefined, // this is a function
    reflexTimerTimeout: 2000,
    triggeredResetTimeout: 1800,
    lastReflexResult: undefined,
  };

  const states = {
    neutral: {
      message: (timer) => `${timer.duration / 1000} second timer ready`,
      current: false,
    },
    triggered: {
      message: (timer) =>
        `${parseFloat(timer.elapsed / 1000).toPrecision(2)} of ${
          timer.duration / 1000
        } seconds remaining`,
      current: false,
    },
    active: {
      message: (timer) => `${timer.duration / 1000} second timer done`,
      current: false,
    },
  };

  let resetMessage = "almost time to boggie";

  const resetButton = (message) => {
    timer.ready = 0;
    resetMessage = `button reset -- ${message}`;
    timer.timerRunning = false;
  };

  const reflextTimerBase = (time) => {
    // let startTime, endTime

    // console.log(startTime);
    if (timer.timerRunning) {
      // set finish time
      timer.reflexEndTime = time;
      // get starttime
      let result = timer.reflexStartTime - timer.reflexEndTime;
      timer.timerRunning = false;

      var seconds = result * -1;
      console.log(seconds + " milli seconds");
      return seconds;
    } else {
      //
      timer.timerRunning = true;
      timer.reflexStartTime = time;
    }
  };

  const changeReflexState = () => {
    if (timer.ready === 0) {
      resetMessage = "  Wait for RED...";
      timer.ready = 1;

      timer.reflexStart = setTimeout(() => {
        timer.ready = 2; // red
        // timer starts here
        reflextTimerBase(new Date());
        //
        resetMessage = "reflex test started";
        // reset after 4 secs
        // TODO : tidy below
        timer.reflexStartReset = setTimeout(
          () => resetButton("Took to long :|"),
          timer.reflexTimerTimeout
        );
      }, timer.reflexStartDelay);
    } else if (timer.ready === 1) {
      // kill timeouts
      //
      clearTimeout(timer.reflexStart);

      resetMessage = "error went to early";

      timer.timerRunning = false;
      setTimeout(() => {
        resetButton("get movin");
      }, timer.triggeredResetTimeout);
    } else if (timer.ready === 2) {
      clearTimeout(timer.reflexStartReset);

      let result = reflextTimerBase(new Date());

      resetButton(`Success :) your time ${result} milli seconds`);
    }
  };
</script>

<button
  class="btn btn-primary my-1"
  on:click={changeReflexState}
  class:state-neutral={timer.ready === 0}
  class:state-triggered={timer.ready === 1}
  class:state-active={timer.ready === 2}
  data-testid="button">button</button
>
<div data-testid="message">
  {resetMessage}
</div>

<style>
  .state-active {
    background-color: red;
  }
  .state-triggered {
    background-color: orange;
  }
</style>
