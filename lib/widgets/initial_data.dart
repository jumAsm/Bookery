import '../models/BookModel.dart';

List<BookModel> initialBookData = [
  BookModel(
    id: "1",
    title: "The Laws of Human Nature",
    author: "Robert Greene",
    description:
    "The book explores the psychological motives driving human behavior. Through 18 laws, Robert Greene teaches how to read people's true intentions, master emotions, and avoid manipulation. Using historical examples, he helps readers understand themselves and others to gain social intelligence and influence. .",
    rating: "4.7",
    coverUrl:
    "assets/placeholder.png", // 👈 تم تغيير الرابط إلى صورة محلية لتجنب مشاكل الشبكة
    bookurl: "placeholder_3.pdf",
    category: "Psychology",
    language: "English",
    createdAt: DateTime.now().toString(),
    pages: 624,
    price: 71,
    isInBasket: false,
    isBookmarked: false,
    isOwned: false,
    isOnSale: true, // الكتاب المعروض للبيع
  ),

  BookModel(
    id: "2",
    title: "عداء الطائرة الورقية",
    author: "خالد حسيني",
    description:
    "  اتتناول الرواية قصة أمير، الفتى الغني من كابول، وصديقه حسن ابن الخادم المخلص. بعد خيانةٍ مؤلمة يرتكبها أمير في طفولته، يعيش صراعًا داخليًا بين الذنب والفداء. مع مرور السنوات وتغيّر أفغانستان تحت حكم طالبان، يعود ليواجه ماضيه ويكفّر عن خطئه القديم في رحلة مؤثرة عن الغفران والإنسانية.",
    rating: "4.4",
    coverUrl:
    "https://i.pinimg.com/736x/c8/24/3a/c8243a6cbde58d4c2aa0465e08e26c7a.jpg",
    bookurl: "placeholder_1.pdf",
    category: "Literature",
    language: "Arabic",
    createdAt: DateTime.now().toString(),
    pages: 543,
    price: 60,
    isInBasket: false,
    isBookmarked: false,
    isOwned: false,
    isOnSale: false,
  ),

  BookModel(
    id: "6",
    title: "Man’s Search for Meaning",
    author: "Viktor E. Frankl",
    description:
    "Written by Holocaust survivor Viktor Frankl, the book explores how finding meaning gives humans the strength to endure suffering. Through his experience in Nazi concentration camps, Frankl develops logotherapy — a philosophy that argues life’s purpose is discovered through resilience, love, and inner freedom.",
    rating: "4.8",
    coverUrl:
    "https://i.pinimg.com/736x/f7/e0/04/f7e0049eb75c37d1865ae533734b8cac.jpg",
    bookurl: "placeholder_4.pdf",
    category: "Psychology",
    language: "English",
    createdAt: DateTime.now().toString(),
    pages: 200,
    price: 55,
    isInBasket: false,
    isBookmarked: false,
    isOwned: false,
    isOnSale: false,
  ),

  BookModel(
    id: "4",
    title: "كافكا على الشاطئ",
    author: "هاروكي موراكامي",
    description:
    "تحكي الرواية حكايتين متوازيتين: الأولى عن كافكا تامورا، فتى يهرب من منزل أبيه بسبب نبوءة مظلمة، والثانية عن ناكاتا، رجل عجوز فقد ذاكرته ويستطيع التحدث مع القطط. تتقاطع القصتان في عالم يمزج بين الواقع والخيال، حيث يبحث الأبطال عن ذواتهم ومعنى القدر والحب والحرية.",
    rating: "4.6",
    coverUrl:
    "https://i.pinimg.com/736x/32/30/47/32304772b1a4c68be65f05e71b95b9ce.jpg",
    bookurl: "placeholder_3.pdf",
    category: "Literature",
    language: "Arabic",
    createdAt: DateTime.now().toString(),
    pages: 615,
    price: 51,
    isInBasket: false,
    isBookmarked: false,
    isOwned: false,
    isOnSale: false,
  ),

  BookModel(
    id: "7",
    title: "The Picture of Dorian Gray",
    author: "Oscar Wilde",
    description:
    "A young man, Dorian Gray, remains eternally youthful while a portrait of him ages and reveals his moral decay. As he pursues pleasure and vanity, the painting becomes a haunting reflection of his corrupted soul. Wilde’s classic novel examines beauty, sin, and the cost of a life devoted to desire.",
    rating: "4.6",
    coverUrl:
    "https://i.pinimg.com/736x/5f/e4/0e/5fe40e0c932a40dab7662e7494707c5e.jpg",
    bookurl: "placeholder_5.pdf",
    category: "Fiction",
    language: "English",
    createdAt: DateTime.now().toString(),
    pages: 254,
    price: 52,
    isInBasket: false,
    isBookmarked: false,
    isOwned: false,
    isOnSale: false,
  ),
  BookModel(
    id: "9",
    title: "What You Are Looking For Is in the Library",
    author: "Michiko Aoyama",
    description:
    "relates five loosely connected stories of five different people who visit a community library in Tokyo, only to find themselves changing for the better, all because of an unexpected book recommendation by the enigmatic librarian. There’s a retail worker who feels her life is stagnating, a woman recently back from maternity leave grappling with her demotion, and several others—all who find new directions and new passion for life, all thanks to the library.",
    rating: "4.6",
    coverUrl:
    "https://i.pinimg.com/1200x/b6/0b/03/b60b037871f3242370c276013733df3c.jpg",
    bookurl: "placeholder_6.pdf",
    category: "Literature",
    language: "English",
    createdAt: DateTime.now().toString(),
    pages: 265,
    price: 79,
    isInBasket: false,
    isBookmarked: false,
    isOwned: false,
    isOnSale: false,
  ),
  BookModel(
    id: "5",
    title: "No Longer Human",
    author: "Osamu Dazai",
    description:
    "Told through the notebooks of Oba Yozo, the story portrays a man who feels completely alienated from society. Despite his outward charm and humor, he suffers from deep loneliness and self-loathing. His descent into addiction and despair reveals a painful exploration of identity, shame, and the loss of humanity. "
        "The smile is nothing more than a puckering of ugly wrinkles.",
    rating: "4.75",
    coverUrl:
    "https://i.pinimg.com/736x/d7/2b/21/d72b2135849f6a65a60a3afbe994551b.jpg",
    bookurl: "placeholder_1.pdf",
    category: "Literature",
    language: "English",
    createdAt: DateTime.now().toString(),
    pages: 271,
    price: 49,
    isInBasket: false,
    isBookmarked: false,
    isOwned: false,
    isOnSale: false,
  ),

  BookModel(
    id: "8",
    title: "رجال في الشمس",
    author: "غسان كنفاني",
    description:
    "تحكي الرواية قصة ثلاثة فلسطينيين يحاولون التسلل إلى الكويت بحثًا عن حياة أفضل بعد النكبة. تجمعهم رحلة قاسية في شاحنة صهريج تحت حرارة الصحراء، وتنتهي بمأساة ترمز إلى ضياع جيل كامل.",
    rating: "4.5",
    coverUrl:
    "https://i.pinimg.com/736x/ae/c5/62/aec5626e5a0fad4409dfd0ab751475bc.jpg",
    bookurl: "placeholder_6.pdf",
    category: "Literature",
    language: "Arabic",
    createdAt: DateTime.now().toString(),
    pages: 110,
    price: 40,
    isInBasket: false,
    isBookmarked: false,
    isOwned: false,
    isOnSale: false,
  ),
  BookModel(
    id: "3",
    title: "The Bell Jar",
    author: "Sylvia Plath",
    description:
    "The novel follows Esther Greenwood, a bright young woman who wins a writing internship in New York but feels trapped by societal expectations. As her mental health deteriorates, she spirals into depression and confinement in a mental institution. The story captures the suffocating pressures faced by women and the search for identity and freedom.",
    rating: "4.0",
    coverUrl:
    "https://i.pinimg.com/1200x/1b/ae/22/1bae226df7df268d2ccb699ef134a811.jpg",
    bookurl: "placeholder_2.pdf",
    category: "Fiction",
    language: "English",
    createdAt: DateTime.now().toString(),
    pages: 294,
    price: 47,
    isInBasket: false,
    isBookmarked: false,
    isOwned: false,
    isOnSale: false,
  ),
];