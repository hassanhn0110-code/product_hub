
import { useState } from "react";
import "./styles/App.css";

function App() {
  const [searchQuery, setSearchQuery] = useState("");
  const products = [
    {
      id: 1,
      name: "Samsung Galaxy",
      price: 85000,
      category: "Smartphones",
      icon: "📱"
    },
    {
      id: 2,
      name: "HP Laptop",
      price: 125000,
      category: "Laptops",
      icon: "💻"
    },
    {
      id: 3,
      name: "Wireless Headphones",
      price: 4500,
      category: "Accessories",
      icon: "🎧"
    }
  ];

  const normalizedQuery = searchQuery.trim().toLowerCase();
  const filteredProducts = products.filter((product) =>
    product.name.toLowerCase().includes(normalizedQuery) ||
    product.category.toLowerCase().includes(normalizedQuery)
  );

  return (
    <div className="app">

      <header className="navbar">
        <h1>ProductHub</h1>

        <nav>
          <a href="#home">Home</a>
          <a href="#products">Products</a>
          <a href="#services">Services</a>
        </nav>
      </header>

      <main>
        <section className="hero" id="home">
          <h2>Welcome to ProductHub</h2>
          <p>Discover amazing electronics at great prices.</p>
          <a href="#products" className="shop-button">
            Explore Products
          </a>
        </section>

        <section className="products-section" id="products">
          <h2>Featured Products</h2>

          <div className="product-search">
            <label htmlFor="product-search">Search products</label>
            <div className="search-controls">
              <input
                id="product-search"
                type="search"
                value={searchQuery}
                onChange={(event) => setSearchQuery(event.target.value)}
                placeholder="Search products by name or category..."
                aria-controls="product-results"
              />
              <button type="button" onClick={() => setSearchQuery("")}>
                Clear search
              </button>
            </div>
          </div>

          <p className="search-status" role="status">
            {filteredProducts.length === 0
              ? "No products found."
              : `${filteredProducts.length} ${filteredProducts.length === 1 ? "product" : "products"} found.`}
          </p>

          <div className="product-grid" id="product-results">
            {filteredProducts.map((product) => (
              <div className="product-card" key={product.id}>
                <div className="product-icon">
                  {product.icon}
                </div>

                <p className="category">
                  {product.category}
                </p>

                <h3>{product.name}</h3>

                <p className="price">
                  Rs. {product.price.toLocaleString()}
                </p>
              </div>
            ))}
          </div>
        </section>

        <section className="services-section" id="services">
          <h2>Our Services</h2>
          <p>Find the best electronics for your needs.</p>
        </section>
      </main>

      <footer>
        <p>© 2026 ProductHub. Demo Website.</p>
      </footer>

    </div>
  );
}

export default App;
