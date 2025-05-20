#!/bin/bash

# Exit on error
set -e

# Define project name
PROJECT_NAME="todo-app"

# Create React app
echo "Creating React app..."
npx create-react-app $PROJECT_NAME

# Navigate to project directory
cd $PROJECT_NAME

# Overwrite App.js with To-Do App code
cat > src/App.js <<'EOF'
import React, { useState } from 'react';

function App() {
  const [tasks, setTasks] = useState([]);
  const [input, setInput] = useState('');

  const addTask = () => {
    if (input.trim() === '') return;
    setTasks([...tasks, { text: input, completed: false }]);
    setInput('');
  };

  const toggleTask = (index) => {
    const newTasks = [...tasks];
    newTasks[index].completed = !newTasks[index].completed;
    setTasks(newTasks);
  };

  const deleteTask = (index) => {
    const newTasks = tasks.filter((_, i) => i !== index);
    setTasks(newTasks);
  };

  return (
    <div style={styles.container}>
      <h1>To-Do List</h1>
      <div style={styles.inputContainer}>
        <input
          style={styles.input}
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder="Enter a task"
        />
        <button style={styles.addButton} onClick={addTask}>Add</button>
      </div>
      <ul style={styles.list}>
        {tasks.map((task, index) => (
          <li
            key={index}
            style={{
              ...styles.task,
              textDecoration: task.completed ? 'line-through' : 'none'
            }}
          >
            <span onClick={() => toggleTask(index)}>{task.text}</span>
            <button style={styles.deleteButton} onClick={() => deleteTask(index)}>❌</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

const styles = {
  container: { maxWidth: 400, margin: '0 auto', padding: 20, fontFamily: 'Arial' },
  inputContainer: { display: 'flex', gap: 10 },
  input: { flex: 1, padding: 10 },
  addButton: { padding: '10px 20px' },
  list: { listStyle: 'none', padding: 0 },
  task: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 10,
    borderBottom: '1px solid #ccc'
  },
  deleteButton: {
    background: 'none',
    border: 'none',
    color: 'red',
    cursor: 'pointer',
    fontSize: 16
  }
};

export default App;
EOF

# Install dependencies (just to be safe)
echo "Installing dependencies..."
npm install

# Launch the app
echo "Starting the development server..."
npm start
