import React, { useState } from 'react'

const FilterInput = ({ id, label, value, setValue, validationRegex, errorMessage }) => {
  const [error, setError] = useState('')

  const handleInputChange = (e) => {
    const inputValue = e.target.value.trim()
    const isValid = validationRegex.test(inputValue)
    if (isValid) {
      setValue(inputValue)
      setError('')
    } else {
      setError(errorMessage)
    }
  }

  return (
    <>
      <label htmlFor={id}>{label}</label>
      <div className={`input-group mb-3 ${error ? 'has-error' : ''}`}>
        <input
          type="text"
          className={`form-control ${error ? 'is-invalid' : ''}`}
          id={id}
          value={value}
          onChange={handleInputChange}
        />
        {error && <span className="invalid-feedback">{error}</span>}
      </div>
    </>
  )
}

export default FilterInput
