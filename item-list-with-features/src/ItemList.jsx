import React, { useState } from 'react'
import "bulma/css/bulma.min.css"
import "./itemList.css"

export const ItemList = ({ data }) => {

  const [input, setInput] = React.useState("")
  const [list, setList] = React.useState([])
  const [editingIndex, setEditingIndex] = useState(-1)

  // const utilities
  const _submitItem = () => {
    if (input === "") { return }
    if (editingIndex >= 0) {
      _editItemAt(editingIndex, input)
      setEditingIndex(-1)
    } else {
      let copy = [...list]
      copy.push(input)
      setList(copy)
    }
    setInput("")

  }

  const _editItemAt = (index, title) => {
    let copy = [...list]
    copy[index] = title
    setList(copy)

  }

  const _removeItemAt = (index) => {
    if (window.confirm(`Press Ok to remove ${list[index]} `) === true) {
      let copy = [...list]
      copy.splice(index, 1)
      setList(copy)
    }

  }

  const _startEditingItemAt = (index) => {
    setEditingIndex(index)
    setInput(list[index])
  }

  return (
    <section className='section'>

      {
        list.map((d, i) => {
          return (
            <Item
              text={d}
              onEditPressed={() => _startEditingItemAt(i)}
              onRemovePressed={() => _removeItemAt(i)}
            />
          )
        })
      }

      <div className='container is-flex is-flex-direction-row'>
        <input className='input' value={input} onChange={e => setInput(e.target.value)} />
        <button title='Add' onClick={_submitItem} >Submit</button>
      </div>
    </section>
  )
}

const Item = ({ text, onEditPressed, onRemovePressed }) => {

  return (
    <div className='container is-flex is-flex-direction-row item' >
      <button title="Done" className='edit-button' onClick={onEditPressed} >Edit</button>
      < button title="Remove" className='remove-button' onClick={onRemovePressed} >Remove</button>

      <p>{text}</p>

    </div>
  )

}