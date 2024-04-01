exports.handler = async (event) => {
  console.log("Event:", JSON.stringify(event, null, 2));
  console.log("LAMBDA WORK GREAT");
  
  return {
      statusCode: 200,
      body: JSON.stringify({ message: "Hello from Lambda!" }),
  };
};
