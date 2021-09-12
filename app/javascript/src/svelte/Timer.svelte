<script>
  const TIMER_RESOLUTION = 100; // all timings will be with 0.1 second
  const timer = {
    duration: 5000, // TODO: should come from server/configuration
    elapsed: 0, // TODO: in future elapsed would also be tracked on server?
    start: undefined,
    interval: undefined,
  };
  const states = {
    ready: {
      message: (timer) => `${timer.duration / 1000} second timer ready`,
    },
    timing: {
      message: (timer) =>
        `${parseFloat(timer.elapsed / 1000).toPrecision(2)} of ${
          timer.duration / 1000
        } seconds remaining`,
    },
    done: {
      message: (timer) => `${timer.duration / 1000} second timer done`,
    },
  };
  let state = "ready";
  const updateTimer = () => {
    timer.elapsed = Date.now() - timer.start;
    if (timer.elapsed >= timer.duration) {
      clearInterval(timer.interval);
      timer.start = undefined;
      timer.interval = undefined;
      timer.elapsed = 0;
      state = "done";
    }
  };
  const readyToTiming = () => {
    state = "timing";
    timer.start = Date.now();
    timer.interval = setInterval(updateTimer, TIMER_RESOLUTION);
  };
  const doneToReady = () => {
    state = "ready";
  };
  const buttonClick = () => {
    switch (state) {
      case "ready": {
        readyToTiming();
        break;
      }
      case "done": {
        doneToReady();
        break;
      }
      default: {
        // TODO: deal with allowing an in progress timer to be reset with a double click?
        console.log("NOT Supported");
      }
    }
  };
</script>

<!-- TODO: move this down to the primary component -->
<button
  on:click={buttonClick}
  class="btn"
  class:btn-primary={state === "ready"}
  class:btn-warning={state === "timing"}
  class:btn-danger={state === "done"}
  data-testid="button">button</button
>
<div data-testid="message">{states[state].message(timer)}</div>

<style>
</style>
