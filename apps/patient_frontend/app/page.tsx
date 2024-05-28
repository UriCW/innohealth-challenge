'use client'
const home = () => {
  const getReadings = async () => {
    const response = await fetch('/api/all_records')
    const ret = await response.json()
    console.log(ret)
  };

  return (
      <button onClick={getReadings}>Get All Records</button>
  )
}
export default home
