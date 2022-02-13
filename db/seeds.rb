EmeterReading.destroy_all
Bill.destroy_all

[
  { date: '31.12.2020', zone_1: 3100, zone_2: 1500, source_type: 'user' },
  { date: '31.01.2021', zone_1: 4113, zone_2: 1858, source_type: 'user' },
  { date: '16.02.2021', zone_1: 4740, zone_2: 2174, source_type: 'controller' },
  { date: '28.02.2021', zone_1: 5395, zone_2: 2463, source_type: 'user' },
  { date: '31.03.2021', zone_1: 6491, zone_2: 3030, source_type: 'user' },
  { date: '11.05.2021', zone_1: 7541, zone_2: 3559, source_type: 'user' },
  { date: '08.06.2021', zone_1: 7932, zone_2: 3663, source_type: 'user' },
  { date: '30.06.2021', zone_1: 8318, zone_2: 3726, source_type: 'controller' },
  { date: '06.07.2021', zone_1: 8399, zone_2: 3735, source_type: 'user' },
  { date: '31.07.2021', zone_1: 8651, zone_2: 3768, source_type: 'controller' },
  { date: '17.08.2021', zone_1: 8863, zone_2: 3799, source_type: 'controller' },
  { date: '12.09.2021', zone_1: 9043, zone_2: 3828, source_type: 'user' },
  { date: '30.09.2021', zone_1: 9509, zone_2: 3958, source_type: 'user' },
  { date: '31.10.2021', zone_1: 10536, zone_2: 4440, source_type: 'user' },
  { date: '30.11.2021', zone_1: 11482, zone_2: 4794, source_type: 'controller' },
  { date: '06.01.2022', zone_1: 13309, zone_2: 5618, source_type: 'user' },
  { date: '08.02.2022', zone_1: 14976, zone_2: 6346, source_type: 'user' }
].each do |params|
  EmeterReading.create!(params)
end
