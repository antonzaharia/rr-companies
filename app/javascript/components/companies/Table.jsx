import React, { useState } from 'react'
import Company from './Company'

const Table = ({ companies }) => {
  return (
    <table className="table">
      <thead>
        <tr>
          <th scope="col">Name</th>
          <th scope="col">Industry</th>
          <th scope="col">Employee Count</th>
          <th scope="col">Total Deal Amount</th>
        </tr>
      </thead>
      <tbody>
        {companies.map((company) => (
          <Company key={company.id} company={company} />
        ))}
      </tbody>
    </table>
  )
}
export default Table
