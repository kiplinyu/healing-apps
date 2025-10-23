import 'package:healing_apps/apps/models/destination_model.dart';

// Daftar data dummy untuk semua destinasi di aplikasi.
// Ini adalah satu-satunya sumber kebenaran (single source of truth) untuk data destinasi.
final List<Destination> dummyDestinations = [
  Destination(
    uuid: "1",
    name: 'Serenity Lake',
    location: 'Bandung, Jawa Barat',
    description:
        'Serenity Lake adalah danau tenang yang dikelilingi hutan pinus dan udara sejuk pegunungan. Airnya jernih, memantulkan langit biru dan pepohonan di sekitarnya, menciptakan suasana damai yang menenangkan pikiran. Tempat ini cocok untuk piknik keluarga ataupun duduk menikmati panorama. ',
    price: 35000,
    rating: 4.9,
    categories: ['Lake', 'Nature', 'Relax'],
    imageUrls: [
      'https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=2070', // Main image
      'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?q=80&w=2070',
      'https://images.unsplash.com/photo-1505159940484-eb2b9f2588e2?q=80&w=1974',
    ],
    isFavorite: true, // Menandakan item ini adalah favorit
  ),
  Destination(
    uuid: "2",
    name: 'Candi Borobudur',
    location: 'Magelang, Jawa Tengah',
    description:
        'Candi Borobudur adalah candi Buddha terbesar di dunia dan salah satu monumen paling megah di Asia Tenggara. Dibangun pada abad ke-9, candi ini dihiasi dengan 2.672 panel relief dan 504 arca Buddha.',
    price: 50000,
    rating: 4.8,
    categories: ['Historic', 'Temple'],
    imageUrls: [
      'https://images.unsplash.com/photo-1596484836645-134d1a6ea863?q=80&w=2070',
    ],
    facilities: ['Toilet', 'Food Court', 'Souvenir Shop'],
    openingHours: '07:30 - 17:00',
    isFavorite: false,
  ),
  Destination(
    uuid: "3",
    name: 'Labuan Bajo',
    location: 'Flores, NTT',
    description:
        'Labuan Bajo adalah gerbang menuju Taman Nasional Komodo yang eksotis. Nikmati pemandangan perbukitan yang menakjubkan, air laut yang jernih, dan kesempatan untuk melihat komodo di habitat aslinya.',
    price: 150000,
    rating: 4.8,
    categories: ['Beach', 'Island', 'Adventure'],
    imageUrls: [
      'https://images.unsplash.com/photo-1577968536374-47c69a5a73f5?q=80&w=1974',
    ],
    isFavorite: true, // Menandakan item ini adalah favorit
  ),
  Destination(
    uuid: "4",
    name: 'Kota Yogyakarta',
    location: 'DIY, Indonesia',
    description:
        'Kota Yogyakarta, atau Jogja, adalah pusat kebudayaan dan seni di Jawa. Jelajahi Keraton, nikmati kuliner khas di Jalan Malioboro, dan rasakan keramahan warganya yang melegenda.',
    price: 20000,
    rating: 4.4,
    categories: ['City', 'Culture'],
    imageUrls: [
      'https://images.unsplash.com/photo-1590242981845-d35276538941?q=80&w=2070',
    ],
    isFavorite: true, // Menandakan item ini adalah favorit
  ),
  Destination(
    uuid: "5",
    name: 'Hidden Waterfall',
    location: 'Lombok, NTB',
    description:
        'Temukan air terjun tersembunyi di tengah hutan tropis Lombok. Rasakan kesegaran airnya dan nikmati ketenangan alam yang masih asri dan belum banyak terjamah.',
    price: 25000,
    rating: 4.9,
    categories: ['Nature', 'Waterfall', 'Adventure'],
    imageUrls: [
      'https://images.unsplash.com/photo-1524338198850-8a2ff63aaceb?q=80&w=1915',
    ],
    isFavorite: false,
  ),
];
