task("deploy", "Deploy contract", async (taskArgs, hre) => {
  if (!taskArgs.unlockTime) {
    throw new Error("unlockTime is required");
  }

  const ContractFactory = await hre.ethers.getContractFactory("Lock");
  const contract = await ContractFactory.deploy(taskArgs.unlockTime);

  console.log("Contarct deployed to:", contract.target);

  const res = await contract.waitForDeployment();
  console.log("**********deployed result:",res);

  const unlockTimeSet = await contract.unlockTime();
  if (unlockTimeSet.toString() !== taskArgs.unlockTime) {
    throw new Error("unlockTime was not set correctly");
  }
}).addParam(
    "unlockTime",
    "The unix timestamp after which the contract will be unlocked."
);
//   .addParam("owner", "The address of the owner of the contract.");
