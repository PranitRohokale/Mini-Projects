import React from "react";
import logo from "./logo.svg";
import "./css/style.css";

// //functional base components
// function App(){
//   // return  at least one compoment
//   return (
//     //JSX expression must only one parent element
//     <div>
//       <h1>Pranit</h1>
//       <mark>Rohokale</mark>
//     </div>
//   );
// }
// export default App;

class App extends React.Component {
  
  constructor(pros) {
    super(pros);
    this.state = {
      newItem: "",
      list: [],
    };

  }
  
  addItem(todoValue) {
    if (todoValue) {
      const newItem = {
        id: Date.now(),
        value: todoValue,
        isDone: false,
      };
      const list = [...this.state.list];
      list.push(newItem);
      this.setState({
        list,
        newItem: "",
      });
      this.state.list.forEach((e) => {
        console.log(e);
      });
    }
  }
  
  deleteItem(id) {
    const list = [...this.state.list];
    const updateList = list.filter((item) => item.id !== id);
    this.setState({
      list: updateList,
      newItem: "",
    });
  }
  changeDone(id) {
    const list = [...this.state.list];
    const updateList = list.map((item) => {
      if (item.id === id) {
        item.isDone = this.isDone ? false : true;
      }
      return item;
    });
    this.setState({
      list: updateList,
      newItem: "",
    });
  }
  
  updateItem(newValue) {
    this.setState({
      newItem: newValue,
    });
  }

  
  render() {
    return (
      <div>
        <h1 className="app-title">◦•●◉✿ 𝒯𝑜 𝒟𝑜 𝒜𝓅𝓅 ✿◉●•◦</h1>
        <div className="container">
          Add an item....
          <br />
          <input
            type="text"
            className="input-text"
            placeholder="Write a todo"
            value={this.state.newItem}
            onChange={(e) => this.updateItem(e.target.value)}
          />
          <button
            className="add-btn"
            onClick={() => {
              this.addItem(this.state.newItem);
              // console.log(this.state.newItem);
            }}
            disabled={!this.state.newItem.length}
          >
            Add
          </button>
          <div className="list">
            <ul>
              {this.state.list.map((e) => {
                return (
                  <li key={e.id} className="todo" >
                    <input
                      type="checkbox"
                      name="isDone"
                      checked={e.isDone}
                      onChange={() => this.changeDone(e.id)}
                    />
                    &nbsp;
                    <p>{e.value}</p>
                    &nbsp;
                    <button onClick={() => this.deleteItem(e.id)}>
                      Delete
                    </button>
                  </li>
                );
              })}
            </ul>
          </div>
        </div>
      </div>
    );
  }
}

export default App;
