async function fetchTodos(){ 
  const trelloResponse = await fetch(
  `{process.env.TRELLO_URL}`
)
console.log(trelloResponse.status);

if (trelloResponse.status === 200) {
  return trelloResponse.json;
}
}

export default function List() {
  const listItems = fetchTodos.map(todo =>
    <li>{todo}</li>
  );
  return <ul>{listItems}</ul>;
}