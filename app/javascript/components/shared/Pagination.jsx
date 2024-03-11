import React from 'react'

const Pagination = ({ currentPage, totalPages, onPageChange }) => {
  const goToPage = (page) => {
    onPageChange(page)
  }

  const goToPrevious = () => {
    onPageChange(Math.max(currentPage - 1, 1))
  }

  const goToNext = () => {
    onPageChange(Math.min(currentPage + 1, totalPages))
  }

  // Dynamically create page links
  const pages = []
  for (let i = 1; i <= totalPages; i++) {
    pages.push(
      <li key={i} className={`page-item ${currentPage === i ? 'active' : ''}`}>
        <a
          className="page-link"
          href="#"
          onClick={(e) => {
            e.preventDefault()
            goToPage(i)
          }}
        >
          {i}
        </a>
      </li>
    )
  }

  // Render the Pagination component only if totalPages is greater than 1
  if (totalPages > 1) {
    return (
      <div className="d-flex justify-content-center">
        <ul className="pagination">
          <li className="page-item">
            <a
              className="page-link"
              href="#"
              onClick={(e) => {
                e.preventDefault()
                goToPrevious()
              }}
            >
              Previous
            </a>
          </li>
          {pages}
          <li className="page-item">
            <a
              className="page-link"
              href="#"
              onClick={(e) => {
                e.preventDefault()
                goToNext()
              }}
            >
              Next
            </a>
          </li>
        </ul>
      </div>
    )
  } else {
    return null // Return null if totalPages is not more than 1
  }
}

export default Pagination
