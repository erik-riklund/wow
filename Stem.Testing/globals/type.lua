validateArguments {
  { label = 'test-undefined', value = nil, types = 'undefined' },
  { label = 'test-boolean', value = true, types = 'boolean' },
  { label = 'test-number', value = 1, types = 'number' },
  { label = 'test-string', value = 'alpha', types = 'string' },
  { label = 'test-array', value = { 1, 2, 3 }, types = 'array' },
  { label = 'test-array-empty', value = {}, types = 'array' },
  { label = 'test-table', value = { a = 'alpha' }, types = 'table' },
  { label = 'test-table-empty', value = {}, types = 'table' },
  { label = 'test-optional', value = nil, types = 'table', optional = true },
}
