<script>
  export let demoButtonId;

  const timer = {
    state: "neutral",
    timerRunning: false,
    reflexStartTime: 0,
    reflexEndTime: 0,
    reflexStartDelay: 1500,
    reflexTimerStart: undefined, // this is a timer
    reflexTimerStartReset: undefined, // this is a timer
    reflexResetState: false,
    reflexTimerTimeout: 3000,
    triggeredResetTimeout: 0,

    messages: {
      reflexInitialMessage: "Press to Start",
      reflexTriggered: "wait to turn active", // wait to turn Red
      reflexActive: "reflex test started",
      reflexExpire: "reflex test has timed out",
      reflextEarly: "too early",
      reflexReset: "Press Again",
      reflexSucces: (result) => `your reflex was ${result}ms`,
    },
  };

  let resetMessage = timer.messages.reflexInitialMessage;

  const resetButton = (message) => {
    timer.state = "neutral";
    resetMessage = `${message}`;
    timer.timerRunning = false;
  };

  const reflextTimerBase = (time) => {
    if (timer.timerRunning) {
      timer.reflexEndTime = time;
      let result = timer.reflexStartTime - timer.reflexEndTime;
      timer.timerRunning = false;
      var seconds = result * -1;

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

      resetMessage = timer.messages.reflexActive;

      timer.reflexTimerStartReset = setTimeout(
        () => resetButton(timer.messages.reflexExpire),
        timer.reflexTimerTimeout
      );
    }, timer.reflexStartDelay);
  };

  const reflexTooEarlyCleanup = (event) => {
    clearTimeout(timer.reflexTimerStart);

    if (timer.reflexResetState) {
      timer.reflexResetState = !timer.reflexResetState;
      setTimeout(() => {
        reflexTestBegins();
      }, timer.triggeredResetTimeout);
    } else {
      timer.reflexResetState = !timer.reflexResetState;
      resetMessage = timer.messages.reflextEarly;
      timer.timerRunning = false;
    }
  };

  const reflexResultHandler = () => {
    clearTimeout(timer.reflexTimerStartReset);

    let result = reflextTimerBase(new Date());

    resetButton(timer.messages.reflexSucces(result));
  };

  const buttonClick = () => {
    console.log(timer.state);
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
