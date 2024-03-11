import React from 'react'

const Company = ({ company }) => {
  return (
    <tr>
      <td>{company.name}</td>
      <td>{company.industry}</td>
      <td>{company.employee_count}</td>
      <td>{company.total_deals_amount}</td>
    </tr>
  )
}

export default Company
