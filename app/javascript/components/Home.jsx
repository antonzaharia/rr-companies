import React, { useEffect, useState } from 'react'

import Error from './shared/Error'
import Table from './companies/Table'
import Pagination from './shared/Pagination'

import { useDebouncedEffect } from '../utils/hooks'

export default () => {
  // List of fetched companies
  const [companies, setCompanies] = useState([])

  // Initial page load flag
  const [isInitialMount, setIsInitialMount] = useState(true)

  // Errors
  const [error, setError] = useState(null)

  // Pagination
  const [currentPage, setCurrentPage] = useState(1)
  const [totalPages, setTotalPages] = useState(1)

  // Table filters
  const [companyName, setCompanyName] = useState('')
  const [industry, setIndustry] = useState('')
  const [minEmployee, setMinEmployee] = useState('')
  const [minimumDealAmount, setMinimumDealAmount] = useState('')

  const handlePageChange = (page) => {
    setCurrentPage(page)
    fetchCompanies(page)
  }

  const queryParams = new URLSearchParams({ companyName, industry, minEmployee, minimumDealAmount }).toString()
  const companiesUrl = `/api/v1/companies?${queryParams}`

  // Fetch companies from API
  const fetchCompanies = (page = 1) => {
    fetch(`${companiesUrl}&page=${page}`)
      .then((response) => {
        if (!response.ok) {
          setError('Network response was not ok')
        }
        return response.json()
      })
      .then((data) => {
        if (data.companies.length === 0) {
          setError('No companies found')
        } else {
          setError(null)
        }
        setCompanies(data.companies)
        setTotalPages(data.meta.pages)
        setCurrentPage(data.meta.page)
        setIsInitialMount(false)
      })
      .catch((error) => setError(`Fetch error: ${error}`))
  }

  // Custom hook to debounce feting the companies
  useDebouncedEffect(
    () => fetchCompanies(),
    [companyName, industry, minEmployee, minimumDealAmount],
    isInitialMount ? 0 : 500
  )

  return (
    <div className="vw-100 primary-color d-flex align-items-center justify-content-center">
      <div className="jumbotron jumbotron-fluid bg-transparent">
        <div className="container secondary-color">
          <h1 className="display-4">Companies</h1>

          <label htmlFor="company-name">Company Name</label>
          <div className="input-group mb-3">
            <input
              type="text"
              className="form-control"
              id="company-name"
              value={companyName}
              onChange={(e) => setCompanyName(e.target.value)}
            />
          </div>

          <label htmlFor="industry">Industry</label>
          <div className="input-group mb-3">
            <input
              type="text"
              className="form-control"
              id="industry"
              value={industry}
              onChange={(e) => setIndustry(e.target.value)}
            />
          </div>

          <label htmlFor="min-employee">Minimum Employee Count</label>
          <div className="input-group mb-3">
            <input
              type="text"
              className="form-control"
              id="min-employee"
              value={minEmployee}
              onChange={(e) => setMinEmployee(e.target.value)}
            />
          </div>

          <label htmlFor="min-amount">Minimum Deal Amount</label>
          <div className="input-group mb-3">
            <input
              type="text"
              className="form-control"
              id="min-amount"
              value={minimumDealAmount}
              onChange={(e) => setMinimumDealAmount(e.target.value)}
            />
          </div>

          <Table companies={companies} />

          {error && <Error message={error} />}

          <Pagination currentPage={currentPage} totalPages={totalPages} onPageChange={handlePageChange} />
        </div>
      </div>
    </div>
  )
}
