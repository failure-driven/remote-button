<script>
  export let dataset;
  const {
    config: { title },
  } = dataset;
  let mode = "reflex";
  const setMode = (newMode) => {
    mode = newMode;
  };
</script>

<h1>{title}!</h1>
<div data-testid="demo-button">
  <button
    class="btn"
    class:active={mode == "reflex"}
    on:click={() => setMode("reflex")}
    data-testid="mode-reflex">reflex</button
  >
  <button
    class="btn"
    class:active={mode == "timer"}
    on:click={() => setMode("timer")}
    data-testid="mode-timer">timer</button
  >
  <button
    class="btn"
    class:active={mode == "counter"}
    on:click={() => setMode("counter")}
    data-testid="mode-counter">counter</button
  >
  <button class="btn btn-primary" data-testid="button">button</button>
  <div data-testid="message">reflex test started</div>
</div>

<style>
  h1 {
    color: #ff3e00;
  }
  button.active {
    background-color: lightblue;
  }
</style>
