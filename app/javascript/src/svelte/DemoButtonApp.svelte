<script>
  import Reflex from "./Reflex.svelte";
  import Timer from "./Timer.svelte";
  import Counter from "./Counter.svelte";
  export let dataset;
  const {
    config: { title, demoButtonId },
  } = dataset;

  let component = Reflex;
  let props = { demoButtonId };

  const setMode = (newMode) => {
    component = newMode;
  };
</script>

<h1>{title}!</h1>
<div data-testid="demo-button">
  <button
    class="btn"
    class:active={component == Reflex}
    on:click={() => setMode(Reflex)}
    data-testid="mode-reflex">reflex</button
  >
  <button
    class="btn"
    class:active={component == Timer}
    on:click={() => setMode(Timer)}
    data-testid="mode-timer">timer</button
  >
  <button
    class="btn"
    class:active={component == Counter}
    on:click={() => setMode(Counter)}
    data-testid="mode-counter">counter</button
  >
  <main>
    <svelte:component this={component} {...props} />
  </main>
</div>

<style>
  h1 {
    color: #ff3e00;
  }
  button.active {
    background-color: lightblue;
  }
</style>
