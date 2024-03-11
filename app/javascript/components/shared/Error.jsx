import React from 'react'

function Error({ message }) {
  return (
    <div className="alert alert-warning" role="alert">
      {message}
    </div>
  )
}
export default Error
