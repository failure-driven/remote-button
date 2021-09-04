<script>
  let count = 0;
  const increment = () => {
    count += 1;
  };
</script>

<!-- TODO: move this down to the primary component -->
<button on:click={increment} class="btn btn-primary" data-testid="button"
  >button</button
>
<div data-testid="message">count {count}</div>

<style>
</style>
