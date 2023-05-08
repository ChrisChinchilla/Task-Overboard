import React, { useState, useEffect } from "react";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";

function App() {
  const [data, setData] = useState([]);
  const getData = () => {
    fetch(
      process.env.REACT_APP_TRELLO_URL,
      {
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
        },
      }
    )
      .then(function (response) {
        // console.log(response);
        return response.json();
      })
      .then(function (trelloResponse) {
        // console.log(myJson);
        setData(trelloResponse);
      });
  };
  useEffect(() => {
    getData();
  }, []);
  return (
    <div className="App">
      <List>
        {data &&
          data.length > 0 &&
          data.map((todo) => <ListItem key={todo.id}>{todo.name}</ListItem>)}
      </List>
    </div>
  );
}

export default App;
