import React, { useState } from 'react'
import FilterInput from './FilterInput'

const FilterForm = ({
  companyName,
  setCompanyName,
  industry,
  setIndustry,
  minEmployee,
  setMinEmployee,
  minimumDealAmount,
  setMinimumDealAmount,
}) => {
  return (
    <>
      <FilterInput
        id="company-name"
        label="Company Name"
        value={companyName}
        setValue={setCompanyName}
        validationRegex={/^[a-zA-Z0-9\s\-]*$/}
        errorMessage="Invalid company name."
      />

      <FilterInput
        id="industry"
        label="Industry"
        value={industry}
        setValue={setIndustry}
        validationRegex={/^[a-zA-Z\s]*$/}
        errorMessage="Invalid company industry."
      />

      <FilterInput
        id="min-employee"
        label="Minimum Employee Count"
        value={minEmployee}
        setValue={setMinEmployee}
        validationRegex={/^[0-9]*$/}
        errorMessage="Invalid employee count."
      />

      <FilterInput
        id="min-amount"
        label="Minimum Deal Amount"
        value={minimumDealAmount}
        setValue={setMinimumDealAmount}
        validationRegex={/^[0-9.]*$/}
        errorMessage="Invalid deal amount."
      />
    </>
  )
}

export default FilterForm
