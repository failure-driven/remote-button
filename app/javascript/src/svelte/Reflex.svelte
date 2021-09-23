<script>
  export let demoButtonId;

  const timer = {
    duration: 5000, // TODO: should come from server/configuration
    // elapsed: 0, // TODO: in future elapsed would also be tracked on server?
    state: "neutral",
    timerRunning: false,
    reflexStartTime: 0,
    reflexEndTime: 0,
    reflexStartDelay: 3000,
    reflexTimerStart: undefined, // this is a function
    reflexTimerStartReset: undefined, // this is a function
    reflexTimerTimeout: 2000,
    triggeredResetTimeout: 1800,

    messages: {
      reflexInitialMessage: "Press to Start",
      reflexTriggered: "Wait for RED...",
      reflexActive: "Click Me Now",
      reflexExpire: "Took to long",
      reflextEarly: "Error went to early",
      reflexReset: "Press Again",
      reflexSucces: (result) => `Success :) your time ${result} milli seconds`,
    },
  };

  let resetMessage = timer.messages.reflexInitialMessage;

  const resetButton = (message) => {
    timer.state = "neutral";
    resetMessage = `button reset - ${message}`;
    timer.timerRunning = false;
  };

  const reflextTimerBase = (time) => {
    if (timer.timerRunning) {
      timer.reflexEndTime = time;

      let result = timer.reflexStartTime - timer.reflexEndTime;
      timer.timerRunning = false;

      var seconds = result * -1;
      console.log(seconds + " milli seconds");
      return seconds;
    } else {
      timer.timerRunning = true;
      timer.reflexStartTime = time;
    }
  };

  const reflexTestBegins = () => {
    resetMessage = timer.messages.reflexTriggered;

    timer.state = "triggered";

    timer.reflexTimerStart = setTimeout(() => {
      timer.state = "active";
      reflextTimerBase(new Date());
      //
      resetMessage = timer.messages.reflexActive;

      timer.reflexTimerStartReset = setTimeout(
        () => resetButton(timer.messages.reflexExpire),
        timer.reflexTimerTimeout
      );
    }, timer.reflexStartDelay);
  };

  const reflexTooEarlyCleanup = () => {
    clearTimeout(timer.reflexTimerStart);

    resetMessage = timer.messages.reflextEarly;

    timer.timerRunning = false;
    setTimeout(() => {
      resetButton(timer.messages.reflexReset);
    }, timer.triggeredResetTimeout);
  };

  const reflexResultHandler = () => {
    clearTimeout(timer.reflexTimerStartReset);

    let result = reflextTimerBase(new Date());

    resetButton(timer.messages.reflexSucces(result));
  };

  const buttonClick = () => {
    switch (timer.state) {
      case "neutral": {
        reflexTestBegins();
        break;
      }
      case "triggered": {
        reflexTooEarlyCleanup();
        break;
      }
      case "active": {
        reflexResultHandler();
        break;
      }
      default: {
        // TODO: deal with allowing an in progress timer to be reset with a double click?
        console.log("NOT Supported");
      }
    }
  };
</script>

<button
  class="btn btn-primary my-1"
  on:click={buttonClick}
  class:state-neutral={timer.state === "neutral"}
  class:state-triggered={timer.state === "triggered"}
  class:state-active={timer.state === "active"}
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
