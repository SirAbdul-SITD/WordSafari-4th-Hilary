// lib/data/word_bank.dart
import 'dart:math';

class WordBank {
  static const Map<String, List<List<String>>> categories = {

    // ── ORIGINAL 10 ──────────────────────────────────────────────────

    'Animals': [
      ['cat', 'dog', 'ant', 'bee', 'hen', 'pig', 'bat', 'cow', 'fox', 'owl', 'emu', 'ram', 'yak', 'gnu', 'asp'],
      ['bear', 'deer', 'duck', 'fish', 'frog', 'goat', 'hare', 'hawk', 'lamb', 'lion', 'mink', 'mole', 'mule', 'newt', 'puma'],
      ['bird', 'bull', 'calf', 'clam', 'crab', 'crow', 'dove', 'ibis', 'kite', 'lynx', 'moth', 'slug', 'toad', 'vole', 'wren'],
      ['cobra', 'crane', 'eagle', 'finch', 'gecko', 'hippo', 'horse', 'hyena', 'koala', 'llama', 'moray', 'quail', 'skunk', 'tapir', 'viper'],
      ['moose', 'mouse', 'otter', 'panda', 'raven', 'shark', 'sloth', 'snail', 'squid', 'stork', 'swift', 'tiger', 'trout', 'whale', 'zebra'],
      ['badger', 'beaver', 'canary', 'donkey', 'falcon', 'ferret', 'gibbon', 'iguana', 'jaguar', 'lizard', 'magpie', 'parrot', 'rabbit', 'toucan', 'walrus'],
      ['cheetah', 'dolphin', 'gorilla', 'hamster', 'leopard', 'lobster', 'mallard', 'meerkat', 'narwhal', 'octopus', 'panther', 'penguin', 'piranha', 'raccoon', 'vulture'],
      ['aardvark', 'alligator', 'butterfly', 'chameleon', 'flamingo', 'hedgehog', 'kangaroo', 'manatee', 'mongoose', 'platypus', 'scorpion', 'seahorse', 'squirrel', 'tortoise', 'wolverine'],
      ['albatross', 'armadillo', 'chimpanzee', 'crocodile', 'dragonfly', 'jellyfish', 'orangutan', 'porcupine', 'rhinoceros', 'salamander', 'tarantula', 'woodpecker', 'barracuda', 'komodo', 'mandrill'],
      ['chimpanzee', 'rhinoceros', 'salamander', 'woodpecker', 'bombardier', 'bottlenose', 'bumblebee', 'capybara', 'cassowary', 'cockatiel', 'copperhead', 'diplodocus', 'earthworm', 'firefly', 'goshawk'],
    ],

    'Food': [
      ['pie', 'jam', 'ham', 'tea', 'egg', 'fig', 'oat', 'rye', 'yam', 'nut', 'cod', 'pea', 'bun', 'dip', 'gin'],
      ['beef', 'beet', 'cake', 'chip', 'chop', 'corn', 'date', 'dill', 'kale', 'kiwi', 'leek', 'lime', 'mint', 'plum', 'rice'],
      ['lamb', 'milk', 'oats', 'pork', 'sage', 'salt', 'soup', 'tofu', 'tuna', 'wrap', 'naan', 'mayo', 'miso', 'taco', 'brie'],
      ['apple', 'bacon', 'basil', 'bread', 'broth', 'candy', 'chili', 'cream', 'curry', 'donut', 'fudge', 'gravy', 'guava', 'honey', 'lemon'],
      ['juice', 'lentil', 'liver', 'lychee', 'mango', 'melon', 'mocha', 'onion', 'pasta', 'peach', 'pesto', 'pizza', 'steak', 'sushi', 'syrup'],
      ['almond', 'banana', 'barley', 'cashew', 'cereal', 'cherry', 'cocoa', 'cookie', 'falafel', 'fondue', 'garlic', 'ginger', 'muffin', 'noodle', 'oyster'],
      ['avocado', 'biscuit', 'brownie', 'burrito', 'caramel', 'cheddar', 'chorizo', 'coconut', 'custard', 'lobster', 'mustard', 'paprika', 'pretzel', 'pudding', 'rhubarb'],
      ['blueberry', 'broccoli', 'cinnamon', 'coleslaw', 'couscous', 'eggplant', 'hazelnut', 'marinara', 'marmalade', 'mozzarella', 'mushroom', 'pistachio', 'pumpkin', 'raspberry', 'tiramisu'],
      ['artichoke', 'asparagus', 'baguette', 'cannelloni', 'carpaccio', 'cheesecake', 'chocolate', 'clementine', 'croissant', 'dumpling', 'enchilada', 'gingerbread', 'guacamole', 'hamburger', 'quesadilla'],
      ['bruschetta', 'cappuccino', 'cheesecake', 'gingerbread', 'mayonnaise', 'peppercorn', 'pomegranate', 'prosciutto', 'strawberry', 'watermelon', 'cannellini', 'hollandaise', 'mascarpone', 'ratatouille', 'vinaigrette'],
    ],

    'Sports': [
      ['ski', 'run', 'hit', 'jog', 'box', 'row', 'swim', 'bowl', 'dive', 'golf', 'kick', 'luge', 'polo', 'surf', 'yoga'],
      ['race', 'sail', 'pass', 'punt', 'slam', 'spin', 'toss', 'walk', 'jump', 'dunk', 'rush', 'spar', 'shot', 'curl', 'flip'],
      ['base', 'bout', 'clay', 'dash', 'draw', 'duel', 'fare', 'foul', 'goal', 'heat', 'lane', 'lift', 'lob', 'pace', 'rink'],
      ['rugby', 'skate', 'serve', 'score', 'shoot', 'pitch', 'pivot', 'relay', 'rally', 'joust', 'block', 'catch', 'cheer', 'coast', 'cross'],
      ['canoe', 'chase', 'climb', 'coach', 'cycle', 'dodge', 'fence', 'guard', 'hurdle', 'kayak', 'match', 'medal', 'power', 'round', 'swing'],
      ['boxing', 'discus', 'diving', 'fencing', 'hockey', 'karate', 'rowing', 'skiing', 'sprint', 'tackle', 'tennis', 'trophy', 'umpire', 'volley', 'wicket'],
      ['archery', 'batting', 'cricket', 'cycling', 'dribble', 'javelin', 'lacrosse', 'penalty', 'surfing', 'athlon', 'bowling', 'canoeing', 'catcher', 'forward', 'freefall'],
      ['baseball', 'football', 'marathon', 'swimming', 'triathlon', 'handball', 'badminton', 'biathlon', 'climbing', 'defender', 'endurance', 'fullback', 'gymnastics', 'halfback', 'overtime'],
      ['athletics', 'bobsleigh', 'decathlon', 'motocross', 'pentathlon', 'taekwondo', 'wrestling', 'waterpolo', 'boardsport', 'breakdance', 'criterium', 'equestrian', 'powerboat', 'skydiving', 'snowboard'],
      ['basketball', 'equestrian', 'skateboard', 'volleyball', 'windsurfing', 'powerlifting', 'racquetball', 'synchronized', 'weightlifting', 'cheerleading', 'competitive', 'decathlete', 'heptathlon', 'Paralympic', 'steeplechase'],
    ],

    'Science': [
      ['lab', 'ion', 'ray', 'gas', 'gel', 'ore', 'atom', 'cell', 'gene', 'lava', 'mass', 'mold', 'nova', 'data', 'acid'],
      ['base', 'bone', 'burn', 'coil', 'core', 'dose', 'flux', 'germ', 'heat', 'lens', 'load', 'loop', 'mole', 'node', 'watt'],
      ['algae', 'alloy', 'amino', 'anode', 'chaos', 'chord', 'clone', 'comet', 'cycle', 'decay', 'delta', 'dense', 'dwarf', 'ember', 'ether'],
      ['fiber', 'field', 'flame', 'fluid', 'focus', 'force', 'fungi', 'laser', 'lidar', 'lunar', 'magma', 'metal', 'phase', 'plasma', 'solid'],
      ['carbon', 'charge', 'enzyme', 'fossil', 'fusion', 'galaxy', 'helium', 'impact', 'liquid', 'magnet', 'matrix', 'neuron', 'oxygen', 'photon', 'proton'],
      ['climate', 'comet', 'cosmic', 'crater', 'crystal', 'fission', 'gravity', 'habitat', 'hormone', 'impulse', 'isotope', 'kinetic', 'nucleus', 'osmosis', 'vaccine'],
      ['alchemy', 'anatomy', 'biology', 'botany', 'catalyst', 'centrifuge', 'chemical', 'conduct', 'density', 'ecology', 'element', 'formula', 'genomics', 'geology', 'inertia'],
      ['asteroid', 'bacteria', 'chemical', 'electron', 'magnetic', 'molecule', 'neutron', 'nitrogen', 'organism', 'periodic', 'reaction', 'spectrum', 'synthesis', 'velocity', 'volatile'],
      ['astronomy', 'chemistry', 'ecosystem', 'evolution', 'frequency', 'magnetism', 'radiation', 'satellite', 'telescope', 'thermodynamic', 'biosphere', 'calculus', 'cytology', 'diffusion', 'electrode'],
      ['atmosphere', 'chromosome', 'combustion', 'conduction', 'electrolyte', 'equilibrium', 'fluorescence', 'gravitational', 'hypothesis', 'microscope', 'oscillation', 'photosynthesis', 'radioactive', 'subatomic', 'wavelength'],
    ],

    'Countries': [
      ['chad', 'cuba', 'fiji', 'iran', 'iraq', 'laos', 'mali', 'oman', 'peru', 'togo', 'niue', 'palau', 'samoa', 'nauru', 'tonga'],
      ['benin', 'chile', 'china', 'egypt', 'ghana', 'haiti', 'india', 'italy', 'japan', 'kenya', 'libya', 'nepal', 'niger', 'qatar', 'spain'],
      ['angola', 'bhutan', 'brazil', 'brunei', 'canada', 'france', 'greece', 'guinea', 'guyana', 'israel', 'jordan', 'kuwait', 'malawi', 'mexico', 'monaco'],
      ['albania', 'algeria', 'armenia', 'austria', 'bahrain', 'belarus', 'bolivia', 'croatia', 'denmark', 'ecuador', 'estonia', 'finland', 'georgia', 'germany', 'hungary'],
      ['iceland', 'ireland', 'jamaica', 'lebanon', 'moldova', 'mongolia', 'morocco', 'myanmar', 'namibia', 'nigeria', 'pakistan', 'panama', 'poland', 'romania', 'senegal'],
      ['argentina', 'australia', 'cambodia', 'colombia', 'ethiopia', 'guatemala', 'indonesia', 'lithuania', 'nicaragua', 'singapore', 'sri lanka', 'tanzania', 'thailand', 'ukraine', 'zimbabwe'],
      ['bangladesh', 'costa rica', 'dominican', 'el salvador', 'hong kong', 'kazakhstan', 'kyrgyzstan', 'mozambique', 'new zealand', 'philippines', 'south korea', 'switzerland', 'tajikistan', 'uzbekistan', 'venezuela'],
      ['afghanistan', 'azerbaijani', 'burkina faso', 'ivory coast', 'liechtenstein', 'luxembourg', 'madagascar', 'netherlands', 'north korea', 'saudi arabia', 'south africa', 'turkmenistan', 'united arab', 'yugoslavia', 'zambia'],
      ['central africa', 'czech republic', 'guinea bissau', 'marshall islands', 'micronesia', 'moldova', 'montenegro', 'papua guinea', 'puerto rico', 'sierra leone', 'solomon islands', 'timor leste', 'trinidad', 'turkmenistan', 'vanuatu'],
      ['antigua barbuda', 'bosnia herzegovina', 'equatorial guinea', 'north macedonia', 'saint kitts nevis', 'saint lucia', 'saint vincent', 'sao tome principe', 'trinidad tobago', 'turkmenistan', 'afghanistan', 'azerbaijan', 'kyrgyzstan', 'liechtenstein', 'luxembourg'],
    ],

    'Nature': [
      ['fog', 'ice', 'mud', 'oak', 'sea', 'sky', 'sun', 'dew', 'ash', 'bay', 'bud', 'dam', 'fen', 'log', 'sap'],
      ['cave', 'clay', 'coal', 'dune', 'dust', 'fern', 'fire', 'gale', 'glen', 'hail', 'hill', 'jade', 'lake', 'leaf', 'mesa'],
      ['bloom', 'brook', 'bluff', 'cedar', 'cliff', 'coral', 'creek', 'delta', 'earth', 'fjord', 'flame', 'flora', 'frost', 'glade', 'gorge'],
      ['grove', 'gusts', 'harbor', 'island', 'jungle', 'lagoon', 'meadow', 'mirage', 'pebble', 'rapids', 'ravine', 'season', 'spring', 'storm', 'swamp'],
      ['boulder', 'canopy', 'canyon', 'crevice', 'crystal', 'current', 'erosion', 'estuary', 'foliage', 'glacier', 'mangrove', 'mineral', 'plateau', 'prairie', 'tundra'],
      ['blizzard', 'blossom', 'cavern', 'cyclone', 'eruption', 'iceberg', 'monsoon', 'mountain', 'rainfall', 'snowflake', 'steppe', 'tempest', 'terrain', 'thunder', 'tornado'],
      ['avalanche', 'continent', 'ecosystem', 'equinox', 'evergreen', 'geysers', 'hurricane', 'peninsula', 'rainforest', 'whirlpool', 'watershed', 'wetlands', 'woodland', 'quartz', 'sediment'],
      ['atmosphere', 'biodiversity', 'earthquake', 'floodplain', 'permafrost', 'subtropical', 'thunderstorm', 'troposphere', 'wilderness', 'savannah', 'grassland', 'limestone', 'stalagmite', 'stalactite', 'tide pool'],
      ['archipelago', 'bioluminescence', 'deforestation', 'desertification', 'geothermal', 'groundwater', 'hibernation', 'hydroelectric', 'microclimate', 'pollination', 'reforestation', 'sedimentation', 'stratosphere', 'vegetation', 'xerophyte'],
      ['afforestation', 'biogeography', 'climatology', 'conservation', 'continental', 'deforestation', 'electromagnetic', 'environmental', 'evolutionary', 'geomorphology', 'hydrosphere', 'lithosphere', 'oceanography', 'photosynthetic', 'thermoregulation'],
    ],

    'Technology': [
      ['app', 'bit', 'bug', 'cpu', 'dns', 'hub', 'log', 'usb', 'web', 'api', 'bot', 'cli', 'git', 'gui', 'ram'],
      ['byte', 'chip', 'code', 'data', 'disk', 'file', 'font', 'game', 'grid', 'icon', 'java', 'link', 'loop', 'menu', 'node'],
      ['ping', 'port', 'sync', 'user', 'wifi', 'blog', 'chat', 'clip', 'drag', 'drop', 'feed', 'hash', 'host', 'html', 'http'],
      ['array', 'audio', 'batch', 'cache', 'cloud', 'debug', 'email', 'error', 'macro', 'patch', 'pixel', 'proxy', 'query', 'queue', 'radar'],
      ['robot', 'route', 'shell', 'token', 'binary', 'cookie', 'cursor', 'daemon', 'decode', 'domain', 'driver', 'encode', 'format', 'gadget', 'memory'],
      ['android', 'browser', 'compile', 'console', 'display', 'encrypt', 'execute', 'firewall', 'gateway', 'graphic', 'network', 'process', 'runtime', 'server', 'socket'],
      ['algorithm', 'antivirus', 'bandwidth', 'bluetooth', 'database', 'download', 'firmware', 'hardware', 'internet', 'keyboard', 'malware', 'metadata', 'middleware', 'protocol', 'software'],
      ['artificial', 'blockchain', 'encryption', 'interface', 'javascript', 'microchip', 'operating', 'processor', 'simulation', 'streaming', 'debugging', 'deployment', 'framework', 'rendering', 'threading'],
      ['application', 'development', 'programming', 'smartphone', 'touchscreen', 'virtualization', 'nanotechnology', 'cryptocurrency', 'cybersecurity', 'containerization', 'architecture', 'compilation', 'distributed', 'parallelism', 'recursion'],
      ['infrastructure', 'machinelearning', 'microservices', 'multithreading', 'objectoriented', 'openstandards', 'optimization', 'orchestration', 'serverless', 'tokenization', 'userexperience', 'authentication', 'authorization', 'cloudcomputing', 'decentralized'],
    ],

    'Emotions': [
      ['joy', 'sad', 'mad', 'awe', 'shy', 'glad', 'calm', 'fear', 'hope', 'love', 'rage', 'envy', 'glee', 'hate', 'hurt'],
      ['bold', 'cozy', 'dull', 'edgy', 'keen', 'lazy', 'lost', 'meek', 'mild', 'numb', 'smug', 'tame', 'warm', 'zeal', 'daze'],
      ['angry', 'bored', 'eager', 'elated', 'proud', 'sorry', 'sweet', 'tense', 'timid', 'weary', 'bliss', 'brave', 'cruel', 'greed', 'happy'],
      ['amused', 'bitter', 'chilly', 'dismay', 'fright', 'humble', 'joyful', 'lonely', 'mellow', 'moody', 'placid', 'serene', 'sullen', 'tender', 'touchy'],
      ['anxious', 'cheerful', 'content', 'devoted', 'ecstasy', 'excited', 'furious', 'gleeful', 'grateful', 'hopeful', 'nervous', 'puzzled', 'restless', 'shocked', 'tranquil'],
      ['confused', 'delighted', 'despair', 'disgusted', 'jealousy', 'melancholy', 'overjoyed', 'relieved', 'terrified', 'agitated', 'ashamed', 'cautious', 'dejected', 'euphoric', 'forlorn'],
      ['admiration', 'affection', 'ambivalent', 'compassion', 'confidence', 'depression', 'frustrated', 'overwhelmed', 'suspicious', 'alienated', 'apathetic', 'bewildered', 'conflicted', 'disgusted', 'enchanted'],
      ['embarrassment', 'exhilaration', 'sentimental', 'triumphant', 'vulnerable', 'contentment', 'anticipation', 'apprehensive', 'introspective', 'bittersweet', 'disillusioned', 'flabbergasted', 'heartbroken', 'melancholic', 'thunderstruck'],
      ['disenchantment', 'lightheartedness', 'magnanimous', 'overwhelmed', 'self-conscious', 'warmhearted', 'awestruck', 'benevolent', 'claustrophobic', 'contemplative', 'disconcerted', 'exasperated', 'flabbergasted', 'gratification', 'introspection'],
      ['disillusionment', 'lightheartedness', 'magnanimousness', 'self-awareness', 'sentimentality', 'wholeheartedness', 'accomplishment', 'astonishment', 'belongingness', 'dissatisfaction', 'enlightenment', 'grandiosity', 'mindfulness', 'purposefulness', 'thoughtfulness'],
    ],

    'Music': [
      ['pop', 'rap', 'beat', 'bass', 'drum', 'horn', 'jazz', 'keys', 'lute', 'note', 'rest', 'riff', 'rock', 'solo', 'tune'],
      ['band', 'bop', 'flat', 'folk', 'fret', 'harp', 'hymn', 'lick', 'oboe', 'pipe', 'raga', 'soul', 'tone', 'vibe', 'wail'],
      ['album', 'blues', 'brass', 'chord', 'clef', 'disco', 'flute', 'forte', 'lyric', 'major', 'march', 'metal', 'minor', 'opera', 'piano'],
      ['pitch', 'pluck', 'pulse', 'remix', 'tempo', 'treble', 'trill', 'viola', 'waltz', 'ballad', 'bridge', 'chorus', 'encore', 'gospel', 'reggae'],
      ['acoustic', 'ambient', 'cadence', 'concert', 'country', 'harmony', 'hip-hop', 'lullaby', 'measure', 'octave', 'quartet', 'quintet', 'refrain', 'rhythm', 'timbre'],
      ['arpeggio', 'classical', 'composer', 'ensemble', 'interval', 'keyboard', 'movement', 'overture', 'playlist', 'symphony', 'virtuoso', 'cappella', 'dynamics', 'notation', 'sonata'],
      ['accordion', 'conductor', 'crescendo', 'diminuendo', 'electronic', 'frequency', 'orchestral', 'saxophone', 'ballpoint', 'baritone', 'bassline', 'bluegrass', 'concerto', 'counterpoint', 'fugue'],
      ['composition', 'discography', 'improvisation', 'microphone', 'performance', 'synthesizer', 'transposition', 'vibrato', 'woodwind', 'acapella', 'allegretto', 'andante', 'chromatic', 'dissonance', 'glissando'],
      ['accompaniment', 'amplification', 'choreography', 'instrumentation', 'musicianship', 'orchestration', 'pentatonic', 'polyphony', 'progression', 'soundtrack', 'staccato', 'syncopation', 'tablature', 'timekeeping', 'tonality'],
      ['countermelody', 'harmonization', 'instrumentation', 'orchestration', 'reverberation', 'soundscape', 'improvisation', 'musicology', 'polyrhythm', 'serialism', 'chromaticism', 'consonance', 'counterpoint', 'dodecaphony', 'microtonality'],
    ],

    'Travel': [
      ['map', 'bus', 'cab', 'fly', 'jet', 'sea', 'tour', 'trek', 'trip', 'visa', 'camp', 'fare', 'gate', 'hike', 'isle'],
      ['boat', 'dock', 'gulf', 'lane', 'pack', 'pier', 'port', 'road', 'sail', 'taxi', 'tent', 'toll', 'wade', 'wake', 'walk'],
      ['atlas', 'cabin', 'canal', 'cargo', 'coast', 'coach', 'crest', 'cruise', 'delta', 'depot', 'ferry', 'globe', 'haven', 'hotel', 'motel'],
      ['oasis', 'ocean', 'plaza', 'ruins', 'bridge', 'castle', 'harbor', 'hostel', 'lounge', 'marina', 'museum', 'resort', 'runway', 'safari', 'shrine'],
      ['airport', 'backpack', 'caravan', 'customs', 'embassy', 'highway', 'journey', 'luggage', 'railway', 'transit', 'arrival', 'charter', 'compass', 'culture', 'descent'],
      ['carnival', 'excursion', 'explorer', 'itinerary', 'passport', 'souvenir', 'terminal', 'vacation', 'adventure', 'boarding', 'cathedral', 'departure', 'migration', 'stopover', 'voyage'],
      ['destination', 'expedition', 'hospitality', 'immigration', 'reservation', 'sightseeing', 'wanderlust', 'wilderness', 'bungalow', 'concierge', 'excursion', 'guidebook', 'peninsula', 'pilgrimage', 'roundtrip'],
      ['accommodation', 'circumnavigate', 'globetrotter', 'international', 'metropolitan', 'transportation', 'archipelago', 'connecting', 'ecotourism', 'expedition', 'geotourism', 'landmark', 'overcrowding', 'sustainable', 'xenophile'],
      ['backpacking', 'crowdsourced', 'cultural immersion', 'ecotourism', 'flashpacking', 'gap year', 'layover', 'solo travel', 'staycation', 'volunteer', 'adventure tourism', 'culinary tour', 'digital nomad', 'heritage site', 'slow travel'],
      ['circumnavigation', 'globetrotting', 'humanitarian', 'infrastructure', 'international', 'metropolitan', 'overcrowding', 'transportation', 'ultramarathon', 'volunteering', 'accommodation', 'backpacking', 'conservation', 'destination', 'exploration'],
    ],

    // ── NEW CATEGORIES ────────────────────────────────────────────────

    'Movies': [
      ['act', 'cut', 'set', 'reel', 'role', 'shot', 'star', 'take', 'trim', 'wrap', 'cast', 'crew', 'edit', 'film', 'prop'],
      ['action', 'cameo', 'drama', 'extra', 'genre', 'indie', 'plot', 'scene', 'score', 'sequel', 'stunt', 'theme', 'title', 'voice', 'zoom'],
      ['cinema', 'comedy', 'dialog', 'dubbed', 'finale', 'horror', 'motion', 'rating', 'reboot', 'remake', 'script', 'studio', 'talent', 'teaser', 'ticker'],
      ['academy', 'casting', 'classic', 'credits', 'fantasy', 'fiction', 'footage', 'musical', 'mystery', 'nominee', 'preview', 'romance', 'subplot', 'cartoon', 'cosplay'],
      ['animated', 'audition', 'backstage', 'blockbuster', 'director', 'ensemble', 'exterior', 'flashback', 'interior', 'premiere', 'producer', 'thriller', 'voiceover', 'western', 'whodunit'],
      ['adventure', 'biography', 'character', 'cliffhanger', 'cinematic', 'closeup', 'cinematography', 'climax', 'franchise', 'narrative', 'plot twist', 'scifi', 'screenplay', 'streaming', 'superhero'],
      ['adaptation', 'antagonist', 'atmosphere', 'box office', 'continuity', 'dialogue', 'exhibition', 'exposition', 'greenlight', 'historical', 'montage', 'multiplex', 'protagonist', 'resolution', 'storyboard'],
      ['blockbuster', 'cinematography', 'documentary', 'establishing', 'independent', 'narration', 'production', 'screenplay', 'soundtrack', 'theatrical', 'animation', 'archetype', 'franchise', 'motif', 'worldbuilding'],
      ['cinematography', 'collaboration', 'commercialism', 'distribution', 'entertainment', 'filmography', 'improvisation', 'mockumentary', 'postproduction', 'screenwriting', 'serialization', 'stereoscopic', 'symbolism', 'visualization', 'worldbuilding'],
      ['cinematographic', 'crowdfunding', 'deconstruction', 'experimental', 'globalization', 'hyperrealism', 'intertextuality', 'postmodernism', 'transmedia', 'verisimilitude', 'auteur', 'expressionism', 'minimalism', 'neorealism', 'surrealism'],
    ],

    'Mythology': [
      ['god', 'war', 'sky', 'sun', 'sea', 'fate', 'fire', 'myth', 'rune', 'soul', 'hero', 'lore', 'muse', 'omen', 'seer'],
      ['ares', 'dusk', 'epic', 'fury', 'hera', 'iris', 'myth', 'thor', 'zeus', 'angel', 'chaos', 'curse', 'demon', 'dryad', 'elfin'],
      ['atlas', 'hydra', 'kraken', 'nymph', 'oracle', 'satyr', 'titan', 'troll', 'witch', 'djinn', 'fairy', 'ghost', 'ghoul', 'golem', 'harpy'],
      ['apollo', 'cronos', 'hermes', 'medusa', 'mermaid', 'minotaur', 'poseidon', 'siren', 'sphinx', 'triton', 'dragon', 'fenrir', 'garuda', 'gryphon', 'kelpie'],
      ['achilles', 'aphrodite', 'cerberus', 'cyclops', 'daedalus', 'dionysus', 'hephaestus', 'hercules', 'odysseus', 'olympus', 'pegasus', 'phoenix', 'theseus', 'ulysses', 'banshee'],
      ['chimera', 'leviathan', 'labyrinth', 'odyssey', 'pantheon', 'persephone', 'prometheus', 'underworld', 'asgard', 'avalon', 'centaur', 'elysium', 'gorgon', 'nirvana', 'valkyrie'],
      ['labyrinth', 'mythology', 'olympian', 'persephone', 'prometheus', 'tartarus', 'ambrosia', 'demi-god', 'elemental', 'immortal', 'legendary', 'mortal', 'shapeshifter', 'supernatural', 'underworld'],
      ['amaterasu', 'gilgamesh', 'minotaur', 'olympians', 'persephone', 'prometheus', 'ragnarok', 'reincarnation', 'shapeshifter', 'supernatural', 'thunderbolt', 'underworld', 'valhalla', 'yggdrasil', 'zeus'],
      ['constellation', 'cosmogony', 'eschatology', 'mythological', 'pantheon', 'reincarnation', 'supernatural', 'theogony', 'astrology', 'divination', 'immortality', 'lycanthropy', 'necromancy', 'polytheism', 'shamanism'],
      ['anthropomorphism', 'cosmological', 'eschatological', 'mythopoeic', 'otherworldly', 'theomorphic', 'transmigration', 'archetypes', 'deification', 'etiological', 'henotheism', 'monolithism', 'pantheistic', 'syncretism', 'theogonic'],
    ],

    'Space': [
      ['sun', 'moon', 'mars', 'star', 'void', 'dust', 'halo', 'orbit', 'ring', 'zero', 'axis', 'burn', 'core', 'dark', 'glow'],
      ['comet', 'crater', 'earth', 'flare', 'lunar', 'nova', 'probe', 'radar', 'solar', 'venus', 'dwarf', 'exo', 'gamma', 'giant', 'light'],
      ['apollo', 'aurora', 'debris', 'eclipse', 'galaxy', 'helium', 'impact', 'meteor', 'nebula', 'photon', 'plasma', 'pulsar', 'quasar', 'rocket', 'saturn'],
      ['asteroid', 'cosmonaut', 'equinox', 'flyover', 'gravity', 'jupiter', 'neptune', 'orbit', 'payload', 'solstice', 'stellar', 'sunspot', 'uranus', 'wormhole', 'xenon'],
      ['blackhole', 'blastoff', 'dark matter', 'exoplanet', 'lightyear', 'moonwalk', 'redshift', 'reentry', 'satellite', 'solarsystem', 'spaceship', 'starlight', 'telescope', 'universe', 'vacuum'],
      ['atmosphere', 'big bang', 'celestial', 'constellation', 'cosmology', 'hubble', 'interstellar', 'launchpad', 'microgravity', 'moonbase', 'nebulae', 'parallax', 'singularity', 'spacetime', 'stargazing'],
      ['astrophysics', 'colonization', 'dark energy', 'dark matter', 'extraterrestrial', 'galactic', 'gravitational', 'interplanetary', 'lightyear', 'magnetosphere', 'multiverse', 'radiation', 'spaceflight', 'terraforming', 'thermosphere'],
      ['astrobiology', 'astronomical', 'astrophysics', 'cosmological', 'exoplanetary', 'gravitational', 'heliocentric', 'heliocentrism', 'interstellar', 'magnetosphere', 'multiversal', 'nebulosity', 'relativistic', 'spectroscopy', 'thermodynamic'],
      ['circumstellar', 'cosmochemistry', 'electromagnetism', 'extraterrestrial', 'gravitational', 'heliocentrism', 'interplanetary', 'magnetosphere', 'nucleosynthesis', 'photospherics', 'relativistic', 'spectroscopy', 'stellar evolution', 'thermodynamics', 'ultraviolet'],
      ['astrodynamics', 'astrogeology', 'astrophotography', 'chromosphere', 'circumnavigation', 'cosmochemistry', 'electrodynamics', 'electromagnetism', 'exoplanetary', 'heliosphere', 'magnetohydrodynamics', 'nucleosynthesis', 'planetesimal', 'thermonuclear', 'ultraviolet'],
    ],

    'History': [
      ['war', 'age', 'era', 'king', 'map', 'myth', 'past', 'pope', 'rule', 'time', 'army', 'arch', 'czar', 'duel', 'epic'],
      ['civil', 'crown', 'dated', 'edict', 'epoch', 'exile', 'feast', 'fleet', 'forge', 'guild', 'joust', 'lance', 'moat', 'plague', 'quest'],
      ['battle', 'castle', 'colony', 'empire', 'feudal', 'knight', 'legion', 'palace', 'pharaoh', 'revolt', 'senate', 'shrine', 'throne', 'treaty', 'tribal'],
      ['ancient', 'crusade', 'dynasty', 'emperor', 'glacier', 'invasion', 'kingdom', 'monarch', 'pilgrim', 'protest', 'republic', 'samurai', 'scholar', 'soldier', 'village'],
      ['artifact', 'chronicle', 'conquest', 'document', 'election', 'famine', 'gladiator', 'heritage', 'medieval', 'monument', 'nobility', 'peasant', 'pyramid', 'reformation', 'timeline'],
      ['armistice', 'cathedral', 'civilization', 'colonialism', 'crusaders', 'democracy', 'feudalism', 'gladiators', 'imperialism', 'inquisition', 'liberation', 'manifesto', 'rebellion', 'revolution', 'sovereignty'],
      ['archaeology', 'aristocracy', 'bureaucracy', 'colonization', 'declaration', 'enlightenment', 'imperialism', 'nationalism', 'occupation', 'persecution', 'propaganda', 'referendum', 'renaissance', 'restoration', 'suffragette'],
      ['agricultural', 'civilization', 'colonialism', 'constitution', 'decentralize', 'dictatorship', 'emancipation', 'feudal system', 'imperialism', 'industrialization', 'mercantilism', 'modernization', 'nationalism', 'reformation', 'renaissance'],
      ['colonization', 'enlightenment', 'globalization', 'imperialism', 'industrialization', 'mercantilism', 'modernization', 'nationalism', 'persecution', 'primogeniture', 'propaganda', 'reformation', 'renaissance', 'sovereignty', 'totalitarianism'],
      ['anthropology', 'archaeology', 'decentralization', 'decolonization', 'enlightenment', 'globalization', 'historiography', 'imperialism', 'industrialization', 'mercantilism', 'modernization', 'nationalism', 'postcolonialism', 'reformation', 'totalitarianism'],
    ],

    'Cooking': [
      ['bake', 'boil', 'chop', 'dice', 'fry', 'grill', 'mash', 'mix', 'pour', 'slice', 'stir', 'toss', 'wash', 'whip', 'zest'],
      ['baste', 'blend', 'braise', 'broil', 'brown', 'caramelize', 'chill', 'coat', 'cool', 'cure', 'deglaze', 'drain', 'dust', 'flambé', 'fold'],
      ['garlic', 'ginger', 'glaze', 'knead', 'ladle', 'marinate', 'mince', 'peel', 'pickle', 'pinch', 'poach', 'puree', 'reduce', 'roast', 'saute'],
      ['season', 'simmer', 'skewer', 'smoke', 'soak', 'steam', 'strain', 'stuff', 'sweat', 'temper', 'toast', 'whisk', 'batter', 'bisque', 'broth'],
      ['blanch', 'clarify', 'confit', 'coulis', 'crudite', 'dredge', 'emulsify', 'flambe', 'julienne', 'macerate', 'parboil', 'render', 'scorch', 'sear', 'swirl'],
      ['al dente', 'beurre', 'brunoise', 'chiffonade', 'consomme', 'deglaze', 'demi-glace', 'emulsion', 'fondant', 'ganache', 'gratinate', 'infusion', 'reduction', 'roux', 'veloute'],
      ['caramelize', 'chiffonade', 'clarification', 'confit', 'deglaze', 'emulsify', 'flambe', 'gratinate', 'julienne', 'macerate', 'meringue', 'parboil', 'reduction', 'tempering', 'vinaigrette'],
      ['braisering', 'caramelizing', 'clarification', 'deconstructed', 'deglazing', 'emulsification', 'fermenting', 'gratinating', 'julienning', 'macerating', 'molecular', 'parboiling', 'rendering', 'sous vide', 'tempering'],
      ['sous vide', 'molecular gastronomy', 'deconstructed', 'emulsification', 'fermentation', 'caramelization', 'clarification', 'spherification', 'gelification', 'transglutaminase', 'aromatics', 'umami', 'maillard', 'mise en place', 'reduction'],
      ['maillard reaction', 'mise en place', 'molecular gastronomy', 'spherification', 'transglutaminase', 'gelification', 'fermentation', 'caramelization', 'emulsification', 'clarification', 'deconstructed', 'sous vide', 'aromatics', 'reduction', 'umami'],
    ],

    'Fashion': [
      ['bow', 'cap', 'dye', 'fur', 'gem', 'hat', 'hem', 'lace', 'pin', 'seam', 'silk', 'trim', 'tutu', 'vest', 'zip'],
      ['belt', 'boot', 'brim', 'cape', 'coat', 'cuff', 'gown', 'heel', 'hood', 'knit', 'lace', 'linen', 'mesh', 'plaid', 'wool'],
      ['apron', 'beret', 'blouse', 'blazer', 'cloak', 'denim', 'drape', 'flare', 'glove', 'gucci', 'jeans', 'khaki', 'model', 'nylon', 'pleat'],
      ['casual', 'chanel', 'chiffon', 'corset', 'couture', 'darling', 'empire', 'fitted', 'formal', 'kimono', 'loafer', 'sandal', 'sequin', 'skirt', 'sleeve'],
      ['brocade', 'bustier', 'cashmere', 'cardigan', 'crochet', 'fashion', 'garment', 'graphic', 'halter', 'miniskirt', 'pallete', 'pockets', 'satchel', 'stiletto', 'vintage'],
      ['bohemian', 'boutique', 'capsule', 'couturier', 'designer', 'ensemble', 'garment', 'glamour', 'lingerie', 'minimalism', 'pantsuit', 'platform', 'polyester', 'tailored', 'tweed'],
      ['accessories', 'aesthetic', 'athleisure', 'collection', 'colorblock', 'embroidery', 'embellish', 'embossed', 'streetwear', 'structured', 'sustainable', 'trendsetter', 'upcycling', 'wardrobe', 'wearable'],
      ['avant-garde', 'capsule collection', 'colorblock', 'contemporary', 'embroidery', 'fashionista', 'pret-a-porter', 'prêt-à-porter', 'streetwear', 'sustainable', 'trendsetter', 'upcycling', 'wearable tech', 'silhouette', 'minimalist'],
      ['avant-garde', 'bespoke', 'contemporary', 'craftsmanship', 'deconstructed', 'editorial', 'fashionista', 'haute couture', 'minimalism', 'pret-a-porter', 'silhouette', 'streetwear', 'sustainable', 'trendsetter', 'upcycling'],
      ['deconstructionism', 'eclecticism', 'fashionability', 'haute couture', 'hyperminimalism', 'maximalism', 'postmodernism', 'sustainability', 'wearability', 'craftsmanship', 'customization', 'embellishment', 'minimalism', 'ornamentation', 'silhouette'],
    ],

    'Art': [
      ['dab', 'dot', 'draw', 'dye', 'hue', 'ink', 'line', 'mix', 'oil', 'pen', 'pose', 'shade', 'sketch', 'tone', 'wash'],
      ['blue', 'bold', 'cast', 'clay', 'crop', 'curl', 'dark', 'form', 'gold', 'gray', 'jade', 'light', 'lime', 'pink', 'tint'],
      ['acrylic', 'canvas', 'carve', 'chisel', 'color', 'draft', 'easel', 'engrave', 'frame', 'fresco', 'glaze', 'mural', 'pastel', 'print', 'pigment'],
      ['bronze', 'charcoal', 'collage', 'contour', 'design', 'etching', 'exhibit', 'gallery', 'gouache', 'graphic', 'pattern', 'pencil', 'plaster', 'relief', 'texture'],
      ['abstract', 'baroque', 'brushwork', 'ceramics', 'contrast', 'cubism', 'digital', 'exhibits', 'figurative', 'graffiti', 'kiln', 'medium', 'mosaic', 'palette', 'realism'],
      ['animation', 'classical', 'composition', 'conceptual', 'engraving', 'exhibition', 'expressionism', 'illustration', 'impression', 'minimalist', 'monochrome', 'photograph', 'portraiture', 'sculpture', 'woodcut'],
      ['chiaroscuro', 'conceptual', 'contemporary', 'expressionist', 'illustration', 'impressionist', 'installation', 'lithography', 'perspective', 'photography', 'portraiture', 'renaissance', 'romanticism', 'surrealism', 'watercolor'],
      ['abstraction', 'composition', 'contemporary', 'deconstruction', 'expressionism', 'illustration', 'impressionism', 'installation', 'photography', 'renaissance', 'romanticism', 'surrealism', 'symbolism', 'vanishing point', 'watercolor'],
      ['abstractionism', 'avant-garde', 'chiaroscuro', 'conceptualism', 'constructivism', 'cubism', 'dadaism', 'expressionism', 'futurism', 'impressionism', 'minimalism', 'modernism', 'neo-classicism', 'postmodernism', 'surrealism'],
      ['abstractionism', 'avant-gardism', 'chiaroscuro', 'constructivism', 'deconstruction', 'expressionism', 'formalism', 'iconography', 'impressionism', 'minimalism', 'modernism', 'postmodernism', 'structuralism', 'surrealism', 'symbolism'],
    ],

    'Body': [
      ['arm', 'ear', 'eye', 'gum', 'hip', 'jaw', 'leg', 'lip', 'rib', 'shin', 'skin', 'toe', 'wrist', 'back', 'bone'],
      ['ankle', 'cheek', 'chest', 'elbow', 'heart', 'heel', 'index', 'joint', 'kneel', 'liver', 'lungs', 'mouth', 'navel', 'nerve', 'scalp'],
      ['bicep', 'brain', 'colon', 'femur', 'fibula', 'finger', 'kidney', 'kneecap', 'muscle', 'pelvis', 'pinky', 'retina', 'spleen', 'tendon', 'tibia'],
      ['abdomen', 'cranium', 'deltoid', 'eardrum', 'eyelash', 'eyelid', 'forearm', 'forehead', 'hamstring', 'larynx', 'molar', 'nostril', 'pupil', 'trachea', 'tricep'],
      ['appendix', 'capillary', 'cartilage', 'cerebrum', 'diaphragm', 'esophagus', 'follicle', 'intestine', 'ligament', 'meninges', 'pancreas', 'pituitary', 'scapula', 'shoulder', 'sternum'],
      ['brainstem', 'capillary', 'cerebellum', 'cochlear', 'diaphragm', 'esophagus', 'fallopian', 'gallbladder', 'hamstring', 'intestine', 'ligament', 'lymph node', 'medulla', 'pancreas', 'pituitary'],
      ['cerebellum', 'circulatory', 'endocrine', 'gallbladder', 'hypothalamus', 'lymphatic', 'muscular', 'nervous', 'respiratory', 'skeletal', 'spinal cord', 'thalamus', 'thyroid', 'urinary', 'vascular'],
      ['cardiovascular', 'cerebellum', 'circulatory', 'endocrine', 'hypothalamus', 'lymphatic', 'musculoskeletal', 'nervous system', 'reproductive', 'respiratory', 'skeletal', 'sympathetic', 'thalamus', 'thyroid', 'urinary'],
      ['cardiovascular', 'cerebellum', 'circulatory', 'endocrine', 'gastrointestinal', 'hypothalamus', 'immunological', 'integumentary', 'lymphatic', 'musculoskeletal', 'nervous', 'reproductive', 'respiratory', 'skeletal', 'urinary'],
      ['bronchiole', 'cardiovascular', 'cerebellum', 'circulatory', 'endocrine', 'gastrointestinal', 'hypothalamus', 'immunological', 'integumentary', 'lymphatic', 'musculoskeletal', 'parasympathetic', 'reproductive', 'sympathetic', 'urinary'],
    ],

    'Weather': [
      ['fog', 'hail', 'ice', 'rain', 'snow', 'sun', 'wind', 'cold', 'damp', 'dew', 'gust', 'heat', 'mist', 'sleet', 'warm'],
      ['balmy', 'breezy', 'clear', 'cloud', 'crisp', 'drizzle', 'dusty', 'front', 'frost', 'humid', 'muggy', 'radar', 'smoggy', 'squall', 'storm'],
      ['arctic', 'blizzard', 'blustery', 'chilly', 'cloudy', 'cyclone', 'drought', 'flooded', 'freezing', 'overcast', 'rainbow', 'showery', 'thunder', 'tornado', 'typhoon'],
      ['barometer', 'dewpoint', 'downpour', 'El Nino', 'forecast', 'frostbite', 'heatwave', 'humidity', 'monsoon', 'pressure', 'rainfall', 'snowfall', 'tropical', 'visibility', 'windchill'],
      ['anticyclone', 'atmosphere', 'cirrostratus', 'cold front', 'depression', 'frontal', 'hurricane', 'isobar', 'jet stream', 'lightning', 'microclimate', 'nimbostratus', 'precipitation', 'stratocumulus', 'thunderstorm'],
      ['cumulonimbus', 'dewpoint', 'evapotranspiration', 'flash flood', 'forecast', 'frontal system', 'hailstorm', 'humid subtropical', 'inversion', 'isolated shower', 'lightning strike', 'meteorology', 'overcast', 'precipitation', 'solar radiation'],
      ['advection fog', 'anticyclone', 'atmospheric pressure', 'cold front', 'convection', 'cyclogenesis', 'dewpoint', 'dust devil', 'evaporation', 'flash flooding', 'fog bank', 'frontal boundary', 'inversion layer', 'monsoon season', 'orographic lift'],
      ['atmospheric', 'climatology', 'cumulonimbus', 'cyclogenesis', 'doppler radar', 'evapotranspiration', 'flash flooding', 'frontal system', 'greenhouse', 'hydrological', 'mesoscale', 'meteorology', 'orographic', 'precipitation', 'synoptic'],
      ['atmospheric river', 'cumulonimbus', 'cyclogenesis', 'doppler radar', 'evapotranspiration', 'frontal system', 'greenhouse effect', 'hydrological cycle', 'mesoscale', 'meteorological', 'orographic lift', 'polar vortex', 'precipitation', 'stratospheric', 'synoptic scale'],
      ['adiabatic lapse rate', 'anticyclonic', 'atmospheric river', 'cumulonimbus', 'cyclogenesis', 'evapotranspiration', 'geostrophic wind', 'hydrological cycle', 'mesoscale convective', 'meteorological', 'orographic precipitation', 'polar vortex', 'stratospheric warming', 'supercell thunderstorm', 'synoptic scale'],
    ],

    'Sports Equipment': [
      ['bat', 'net', 'oar', 'pad', 'pin', 'puck', 'rack', 'rod', 'rope', 'sail', 'ski', 'tee', 'vest', 'bar', 'bob'],
      ['ball', 'bike', 'boot', 'cage', 'club', 'dart', 'disc', 'flag', 'foam', 'goal', 'glove', 'hoop', 'kite', 'lane', 'mask'],
      ['arrow', 'baton', 'board', 'chalk', 'court', 'guard', 'kayak', 'pedal', 'saddle', 'skate', 'spike', 'stick', 'strap', 'track', 'wheel'],
      ['basket', 'buckle', 'bumper', 'cleats', 'diving', 'helmet', 'jersey', 'jogger', 'mallet', 'netting', 'paddle', 'racket', 'ribbon', 'shorts', 'wicket'],
      ['archery', 'barbell', 'batting', 'bowling', 'dumbbell', 'goggles', 'harness', 'javelin', 'lacrosse', 'leotard', 'mitt', 'nunchuck', 'putter', 'quiver', 'saddle'],
      ['backstroke', 'balance beam', 'basketball', 'boxing glove', 'crossbow', 'discus', 'fishing rod', 'football', 'golf club', 'gymnastics', 'hammerhead', 'javelin', 'kettlebell', 'parachute', 'speargun'],
      ['badminton racket', 'balance board', 'baseball glove', 'boxing shorts', 'climbing shoes', 'diving board', 'football helmet', 'golf putter', 'hockey stick', 'javelin throw', 'kayak paddle', 'life jacket', 'parachute', 'resistance band', 'swimming cap'],
      ['abdominal belt', 'archery quiver', 'balance beam', 'baseball diamond', 'boxing handwraps', 'climbing harness', 'cycling helmet', 'diving cylinder', 'football pads', 'gymnastics mat', 'hockey puck', 'kayak cockpit', 'padded shorts', 'resistance band', 'swimming goggles'],
      ['abdominal support', 'archery equipment', 'balance apparatus', 'baseball equipment', 'boxing equipment', 'climbing equipment', 'cycling equipment', 'diving equipment', 'football equipment', 'gymnastics apparatus', 'hockey equipment', 'kayaking equipment', 'swimming equipment', 'resistance training', 'weight training'],
      ['biomechanical', 'cardiovascular', 'ergonomic', 'high performance', 'hydrodynamic', 'impact resistance', 'kinesiological', 'lightweight', 'multifunctional', 'performance-enhancing', 'physiological', 'pressurized', 'shock-absorbing', 'streamlined', 'thermodynamic'],
    ],

    'Professions': [
      ['chef', 'cop', 'doc', 'vet', 'nun', 'monk', 'nurse', 'aide', 'maid', 'dean', 'tutor', 'judge', 'guard', 'guide', 'pilot'],
      ['actor', 'agent', 'baker', 'clerk', 'coach', 'diver', 'driver', 'ductor', 'elder', 'guard', 'mayor', 'miner', 'model', 'nurse', 'ranger'],
      ['archer', 'artist', 'banker', 'barber', 'brewer', 'broker', 'butler', 'carver', 'cashier', 'cleric', 'coder', 'dancer', 'farmer', 'fisher', 'healer'],
      ['auditor', 'builder', 'dentist', 'florist', 'manager', 'plumber', 'surgeon', 'teacher', 'trainer', 'analyst', 'captain', 'chemist', 'colonel', 'courier', 'doorman'],
      ['animator', 'attorney', 'botanist', 'diplomat', 'director', 'engineer', 'geologist', 'lifeguard', 'mechanic', 'musician', 'novelist', 'optician', 'reporter', 'sculptor', 'therapist'],
      ['accountant', 'ambassador', 'astronomer', 'biologist', 'cardiologist', 'dietitian', 'filmmaker', 'geographer', 'historian', 'journalist', 'magistrate', 'pharmacist', 'physician', 'programmer', 'sociologist'],
      ['archaeologist', 'biochemist', 'cardiologist', 'chiropractor', 'criminologist', 'dermatologist', 'entomologist', 'epidemiologist', 'gynecologist', 'immunologist', 'microbiologist', 'neurologist', 'obstetrician', 'ophthalmologist', 'orthodontist'],
      ['anesthesiologist', 'anthropologist', 'cardiologist', 'criminologist', 'dermatologist', 'endocrinologist', 'epidemiologist', 'gastroenterologist', 'gerontologist', 'hematologist', 'immunologist', 'microbiologist', 'nephrologist', 'neurologist', 'oncologist'],
      ['anesthesiologist', 'anthropologist', 'bacteriologist', 'cardiologist', 'climatologist', 'criminologist', 'endocrinologist', 'epidemiologist', 'gastroenterologist', 'gerontologist', 'hematologist', 'immunologist', 'microbiologist', 'nephrologist', 'oncologist'],
      ['anesthesiologist', 'biomedical engineer', 'cardiovascular', 'communications', 'criminologist', 'endocrinologist', 'epidemiologist', 'gastroenterologist', 'gerontologist', 'hematologist', 'immunologist', 'microbiologist', 'neurologist', 'oncologist', 'radiologist'],
    ],

  };

  static List<String> getWordsForLevel(String category, int level) {
    final cat = categories[category];
    if (cat == null) return [];
    final levelIndex = (level - 1).clamp(0, cat.length - 1);
    return List<String>.from(cat[levelIndex]);
  }

  static List<String> get allCategories => categories.keys.toList();

  static String scramble(String word) {
    if (word.length <= 1) return word;
    final chars = word.split('');
    final rng = Random(DateTime.now().microsecondsSinceEpoch);
    int attempts = 0;
    do {
      chars.shuffle(rng);
      attempts++;
    } while (chars.join() == word && attempts < 50);
    return chars.join();
  }
}
