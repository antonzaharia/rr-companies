import React, { useEffect } from 'react'

const useDebouncedEffect = (effect, deps, delay) => {
  useEffect(() => {
    const handler = setTimeout(() => effect(), delay)

    return () => clearTimeout(handler)
  }, [...deps, delay])
}

export { useDebouncedEffect }
