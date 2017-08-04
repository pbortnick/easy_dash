customer = Customer.create(
  first_name:   'John',
  last_name:    'Doe',
  email:        "john_doe#{SecureRandom.hex(6)}@example.com"
)

# Create Customer on Stripe
token = Stripe::Token.create(
  :card => {
    :number => "4242424242424242",
    :exp_month => 1,
    :exp_year => 2020,
    :cvc => "643"
  }
)

stripe_customer = Stripe::Customer.create(
  card: token.id,
  description: "#{customer.id}",
  email: "#{customer.email}"
)
customer.stripe_id = stripe_customer.id
customer.save


cat_1 = Category.create(
  name: 'health_and_beauty'
)
cat_2 = Category.create(
  name: 'bevrage_and_grocery'
)
cat_3 = Category.create(
  name: 'household_and_office'
)

p1 = Product.create(
  name: 'colgate',
  title: 'colgate',
  price: 400,
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  category: cat_1
)

p2 = Product.create(
  name: 'fiji',
  title: 'fiji',
  price: 500,
  description: 'Vestibulum commodo nunc ex, at pretium tortor rutrum elementum.',
  category: cat_2
)

p3 = Product.create(
  name: 'redbull',
  title: 'redbull',
  price: 300,
  description: 'Proin luctus mi a lorem sagittis suscipit.',
  category: cat_2
)

p4 = Product.create(
  name: 'bounty',
  title: 'bounty',
  price: 250,
  description: 'Aenean feugiat sed dolor ut ultrices.',
  category: cat_3
)

p5 = Product.create(
  name: 'tide',
  title: 'tide',
  price: 1600,
  description: 'Praesent suscipit posuere quam, eu sodales est malesuada at.',
  category: cat_3
)

Plan.create(
  name: 'colgate_plan',
  product: p1
)

Plan.create(
  name: 'fiji_plan',
  product: p2
)

Plan.create(
  name: 'redbull_plan',
  product: p3
)

Plan.create(
  name: 'bounty_plan',
  product: p4
)

Plan.create(
  name: 'tide_plan',
  product: p5
)
