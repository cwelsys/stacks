const stacks = await komodo.read("ListStacks", {});

// First refresh the 'latest_hash' for all the stacks which have a deployed_hash
for (const stack of stacks) {
  if (stack.info.deployed_hash) {
    await komodo.write("RefreshStackCache", { stack: stack.name });
  }
}

// Get stacks again after refreshing the latest hash
const refreshed = await komodo.read("ListStacks", {});
for (const stack of refreshed) {
  // Check for different hash, and deploy
  if (stack.info.deployed_hash !== stack.info.latest_hash) {
    console.log(`Stack ${stack.name} has new commits. Redeploying...`);
    await komodo.execute("DeployStack", { stack: stack.name });
  }
}
