<script>
  import { onMount } from "svelte";
  import { getButton, pressButton } from "../services/button.js";

  export let demoButtonId;

  let count;

  const increment = () => {
    pressButton({ buttonId: demoButtonId })
      .then(() => getButton({ buttonId: demoButtonId }))
      .then((response) => response.json())
      .then((jsonResponse) => (count = jsonResponse.count));
  };

  onMount(() => {
    getButton({ buttonId: demoButtonId })
      .then((response) => response.json())
      .then((jsonResponse) => (count = jsonResponse.count));
  });
</script>

<!-- TODO: move this down to the primary component -->
<button on:click={increment} class="btn btn-primary" data-testid="button"
  >button</button
>
<div data-testid="message">count {count}</div>

<style>
</style>
