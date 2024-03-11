import React, { useState, useEffect } from 'react'

import Error from './shared/Error'
import Table from './companies/Table'
import Pagination from './shared/Pagination'
import FilterForm from './companies/FilterForm'

import { useDebouncedEffect } from '../utils/hooks'

const Home = () => {
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
      })
      .catch((error) => setError(`Fetch error: ${error}`))
  }

  // Custom hook to debounce feting the companies
  useDebouncedEffect(() => {
    if (!isInitialMount) {
      fetchCompanies()
    }
  }, [companyName, industry, minEmployee, minimumDealAmount], 500)

  // First Page load
  useEffect(() => {
    fetchCompanies()
    setIsInitialMount(false)
  }, [])

  return (
    <div className="vw-100 primary-color d-flex align-items-center justify-content-center">
      <div className="jumbotron jumbotron-fluid bg-transparent">
        <div className="container secondary-color">
          <h1 className="display-4">Companies</h1>
          <FilterForm
            {...{
              companyName,
              setCompanyName,
              industry,
              setIndustry,
              minEmployee,
              setMinEmployee,
              minimumDealAmount,
              setMinimumDealAmount,
            }}
          />
          <Table companies={companies} />

          {error && <Error message={error} />}

          <Pagination currentPage={currentPage} totalPages={totalPages} onPageChange={handlePageChange} />
        </div>
      </div>
    </div>
  )
}

export default Home
