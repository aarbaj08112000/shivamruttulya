<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shiv Amruttulya | Every Sip Tells a Story</title>
    <link rel="icon" type="image/png" href="<?php echo base_url('public/uploads/fav_shiv_amruttulya.png'); ?>">

    <!-- SEO Meta Tags -->
    <meta name="description"
        content="Experience the authentic taste of premium tea, coffee, and delicious snacks at Shiv Amruttulya.">
    <meta name="keywords" content="Tea, Coffee, Cafe, Shiv Amruttulya, Maska Bun, Premium Tea">

    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@600;700&display=swap"
        rel="stylesheet">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- AOS Animation CSS -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />

    <!-- GLightbox CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/glightbox/dist/css/glightbox.min.css" />

    <style>
        :root {
            --primary-brown: #4a2e15;
            --secondary-brown: #6b4423;
            --gold: #d4af37;
            --light-gold: #f3e5ab;
            --cream: #fffdd0;
            --off-white: #fcf9f2;
            --text-dark: #333333;
            --text-light: #777777;
        }

        body {
            font-family: 'Poppins', sans-serif;
            color: var(--text-dark);
            background-color: var(--off-white);
            overflow-x: hidden;
        }

        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-brown);
        }

        /* Preloader */
        #preloader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--cream);
            z-index: 9999;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 5px solid var(--light-gold);
            border-top: 5px solid var(--secondary-brown);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        /* Navbar */
        .navbar {
            transition: all 0.4s ease;
            padding: 20px 0;
            background: transparent;
        }

        .navbar.scrolled {
            background: rgba(255, 255, 255, 0.95);
            padding: 10px 0;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            backdrop-filter: blur(10px);
        }

        .navbar-brand {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--gold) !important;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }

        .navbar.scrolled .navbar-brand {
            color: var(--primary-brown) !important;
            text-shadow: none;
        }

        .nav-link {
            color: #fff !important;
            font-weight: 500;
            margin: 0 10px;
            position: relative;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }

        .navbar.scrolled .nav-link {
            color: var(--text-dark) !important;
            text-shadow: none;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--gold);
            transition: width 0.3s ease;
        }

        .nav-link:hover::after,
        .nav-link.active::after {
            width: 100%;
        }

        /* Hero Section */
        #hero {
            height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('<?php echo base_url("public/images/home/hero.png"); ?>') center/cover no-repeat fixed;
            display: flex;
            align-items: center;
            position: relative;
        }

        .hero-content h1 {
            color: #fff;
            font-size: 4.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .hero-content p {
            color: var(--cream);
            font-size: 1.2rem;
            margin-bottom: 40px;
            font-weight: 300;
        }

        .btn-custom {
            background-color: var(--gold);
            color: var(--primary-brown);
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid var(--gold);
            text-decoration: none;
            display: inline-block;
        }

        .btn-custom:hover {
            background-color: transparent;
            color: var(--gold);
        }

        .btn-outline-custom {
            background-color: transparent;
            color: #fff;
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid #fff;
            text-decoration: none;
            display: inline-block;
            margin-left: 15px;
        }

        .btn-outline-custom:hover {
            background-color: #fff;
            color: var(--primary-brown);
        }

        /* Section Titles */
        .section-title {
            text-align: center;
            margin-bottom: 60px;
        }

        .section-title h2 {
            font-size: 2.5rem;
            position: relative;
            display: inline-block;
            padding-bottom: 15px;
        }

        .section-title h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: var(--gold);
        }

        /* About Section */
        #about {
            padding: 100px 0;
            background-color: #fff;
        }

        .about-img {
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .about-img:hover {
            transform: translateY(-10px);
        }

        .about-feature {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .about-feature i {
            font-size: 1.5rem;
            color: var(--gold);
            margin-right: 15px;
            background: var(--cream);
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }

        /* Menu Section */
        #menu {
            padding: 100px 0;
            background-color: var(--off-white);
        }

        .menu-card {
            background: #fff;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            height: 100%;
        }

        .menu-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
        }

        .menu-img-wrapper {
            position: relative;
            overflow: hidden;
            height: 250px;
        }

        .menu-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .menu-card:hover .menu-img {
            transform: scale(1.1);
        }

        .menu-price {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--gold);
            color: var(--primary-brown);
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
            z-index: 1;
        }

        .menu-content {
            padding: 25px;
        }

        .menu-category {
            color: var(--gold);
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 10px;
            display: block;
        }

        /* Why Choose Us */
        #features {
            padding: 100px 0;
            background-color: var(--primary-brown);
            color: #fff;
        }

        #features .section-title h2 {
            color: #fff;
        }

        .feature-box {
            background: rgba(255, 255, 255, 0.05);
            padding: 40px 30px;
            border-radius: 15px;
            text-align: center;
            transition: all 0.3s ease;
            height: 100%;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .feature-box:hover {
            background: rgba(212, 175, 55, 0.1);
            transform: translateY(-5px);
            border-color: var(--gold);
        }

        .feature-icon {
            font-size: 3rem;
            color: var(--gold);
            margin-bottom: 20px;
        }

        .feature-box h4 {
            color: #fff;
            margin-bottom: 15px;
        }

        .feature-box p {
            color: #ccc;
            font-size: 0.95rem;
            margin: 0;
        }

        /* Gallery */
        #gallery {
            padding: 100px 0;
            background-color: #fff;
        }

        .gallery-item {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            margin-bottom: 24px;
            cursor: pointer;
        }

        .gallery-item img {
            width: 100%;
            transition: transform 0.5s ease;
        }

        .gallery-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(74, 46, 21, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .gallery-item:hover img {
            transform: scale(1.05);
        }

        .gallery-item:hover .gallery-overlay {
            opacity: 1;
        }

        .gallery-overlay i {
            color: #fff;
            font-size: 2rem;
            transform: translateY(20px);
            transition: transform 0.3s ease;
        }

        .gallery-item:hover .gallery-overlay i {
            transform: translateY(0);
        }

        /* Reviews */
        #reviews {
            padding: 100px 0;
            background-color: var(--off-white);
        }

        .testimonial-card {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            margin: 20px 10px;
        }

        .testimonial-text {
            font-style: italic;
            color: var(--text-light);
            margin-bottom: 20px;
            position: relative;
        }

        .testimonial-text::before {
            content: '\f10d';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            position: absolute;
            top: -15px;
            left: -15px;
            font-size: 2rem;
            color: var(--cream);
            z-index: 0;
        }

        .client-info {
            display: flex;
            align-items: center;
            position: relative;
            z-index: 1;
        }

        .client-img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 15px;
            border: 3px solid var(--gold);
        }

        .client-details h5 {
            margin: 0;
            font-size: 1.1rem;
            font-family: 'Poppins', sans-serif;
        }

        .stars {
            color: var(--gold);
            font-size: 0.9rem;
        }

        .swiper-pagination-bullet-active {
            background: var(--gold);
        }

        /* Contact & Visit Us */
        #contact {
            padding: 100px 0;
            background-color: #fff;
        }

        .contact-info-box {
            background: var(--cream);
            padding: 40px;
            border-radius: 15px;
            height: 100%;
        }

        .info-item {
            display: flex;
            margin-bottom: 30px;
        }

        .info-icon {
            width: 50px;
            height: 50px;
            background: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--gold);
            font-size: 1.2rem;
            margin-right: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .contact-form .form-control {
            padding: 12px 20px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            margin-bottom: 20px;
            background: var(--off-white);
        }

        .contact-form .form-control:focus {
            box-shadow: none;
            border-color: var(--gold);
        }

        .map-container {
            border-radius: 15px;
            overflow: hidden;
            height: 300px;
            margin-top: 30px;
        }

        /* Footer */
        footer {
            background-color: var(--primary-brown);
            color: #fff;
            padding: 60px 0 20px;
        }

        .footer-logo {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--gold);
            margin-bottom: 20px;
            display: block;
            text-decoration: none;
        }

        .footer-text {
            color: #ccc;
            margin-bottom: 20px;
        }

        .social-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            border-radius: 50%;
            margin-right: 10px;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .social-links a:hover {
            background: var(--gold);
            transform: translateY(-3px);
        }

        .footer-links h4 {
            color: #fff;
            margin-bottom: 20px;
            font-size: 1.2rem;
        }

        .footer-links ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .footer-links li {
            margin-bottom: 12px;
        }

        .footer-links a {
            color: #ccc;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--gold);
            padding-left: 5px;
        }

        .copyright {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 20px;
            margin-top: 40px;
            text-align: center;
            color: #aaa;
            font-size: 0.9rem;
        }

        /* Scroll to Top */
        #scroll-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 45px;
            height: 45px;
            background: var(--gold);
            color: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            cursor: pointer;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            z-index: 999;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        #scroll-top.active {
            opacity: 1;
            visibility: visible;
        }

        #scroll-top:hover {
            background: var(--primary-brown);
            transform: translateY(-3px);
        }

        @media (max-width: 768px) {
            .hero-content h1 {
                font-size: 3rem;
            }

            .navbar {
                background: rgba(255, 255, 255, 0.95);
                padding: 10px 0;
            }

            .navbar-brand {
                color: var(--primary-brown) !important;
            }

            .nav-link {
                color: var(--text-dark) !important;
            }
        }
    </style>
</head>

<body data-bs-spy="scroll" data-bs-target="#navbar" data-bs-offset="100">

    <!-- Preloader -->
    <div id="preloader">
        <div class="spinner"></div>
    </div>

    <!-- Navbar -->
    <nav id="navbar" class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="<?php echo base_url('public/uploads/fav_shiv_amruttulya.png'); ?>" alt="Shiv Amruttulya Logo"
                    height="50" class="me-2">
                <span class="d-none d-sm-inline">Shiv Amruttulya</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="#hero">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="#menu">Menu</a></li>
                    <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                    <li class="nav-item"><a class="nav-link" href="#gallery">Gallery</a></li>
                    <li class="nav-item"><a class="nav-link" href="#reviews">Reviews</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 hero-content" data-aos="fade-up" data-aos-duration="1000">
                    <h1>Every Sip Tells a Story</h1>
                    <p>Experience the authentic taste of premium tea, coffee, and delicious snacks at Shiv Amruttulya. A
                        perfect blend of tradition and taste.</p>
                    <a href="#menu" class="btn-custom">View Menu</a>
                    <a href="#contact" class="btn-outline-custom">Visit Our Shop</a>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-5 mb-lg-0" data-aos="fade-right" data-aos-duration="1000">
                    <img src="<?php echo base_url('public/website/about.png'); ?>" alt="About Shiv Amruttulya"
                        class="img-fluid about-img w-100">
                </div>
                <div class="col-lg-6 ps-lg-5" data-aos="fade-left" data-aos-duration="1000">
                    <div class="section-title text-start mb-4">
                        <h2>Our Story</h2>
                    </div>
                    <p class="mb-4">Welcome to Shiv Amruttulya, where every cup is brewed with passion and tradition. We
                        believe that tea is not just a beverage; it's an emotion that brings people together. Our
                        journey started with a simple goal: to serve the most authentic, refreshing, and premium quality
                        tea.</p>

                    <div class="about-feature">
                        <i class="fas fa-leaf"></i>
                        <div>
                            <h5 class="mb-1">Premium Quality</h5>
                            <p class="text-muted mb-0">Handpicked tea leaves for the perfect aroma.</p>
                        </div>
                    </div>
                    <div class="about-feature">
                        <i class="fas fa-utensils"></i>
                        <div>
                            <h5 class="mb-1">Fresh Ingredients</h5>
                            <p class="text-muted mb-0">We use only the freshest ingredients every day.</p>
                        </div>
                    </div>
                    <div class="about-feature">
                        <i class="fas fa-hands-bubbles"></i>
                        <div>
                            <h5 class="mb-1">Hygienic Preparation</h5>
                            <p class="text-muted mb-0">Cleanliness and hygiene are our top priorities.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Menu Section -->
    <section id="menu">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>Our Special Menu</h2>
                <p class="text-muted mt-3">Discover our hand-crafted beverages and delicious snacks.</p>
            </div>

            <div class="row g-4">
                <!-- Menu Item 1 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="menu-card">
                        <div class="menu-img-wrapper">
                            <span class="menu-price">₹15</span>
                            <img src="<?php echo base_url('public/website/tea.png'); ?>" alt="Special Tea"
                                class="menu-img">
                        </div>
                        <div class="menu-content">
                            <span class="menu-category">Hot Beverage</span>
                            <h4>Special Amruttulya Tea</h4>
                            <p class="text-muted">Our signature blend of premium tea leaves with special Indian spices.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Menu Item 2 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="menu-card">
                        <div class="menu-img-wrapper">
                            <span class="menu-price">₹30</span>
                            <img src="<?php echo base_url('public/website/maska_bun.png'); ?>" alt="Maska Bun"
                                class="menu-img">
                        </div>
                        <div class="menu-content">
                            <span class="menu-category">Snacks</span>
                            <h4>Classic Maska Bun</h4>
                            <p class="text-muted">Freshly baked soft bun generously spread with premium butter.</p>
                        </div>
                    </div>
                </div>

                <!-- Menu Item 3 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="menu-card">
                        <div class="menu-img-wrapper">
                            <span class="menu-price">₹25</span>
                            <img src="<?php echo base_url('public/website/filter_coffee.png'); ?>" alt="Coffee"
                                class="menu-img">
                        </div>
                        <div class="menu-content">
                            <span class="menu-category">Hot Beverage</span>
                            <h4>Premium Filter Coffee</h4>
                            <p class="text-muted">Authentic South Indian style filter coffee brewed to perfection.</p>
                        </div>
                    </div>
                </div>

                <!-- Menu Item 4 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="menu-card">
                        <div class="menu-img-wrapper">
                            <span class="menu-price">₹50</span>
                            <img src="<?php echo base_url('public/website/sandwich.png'); ?>" alt="Sandwich"
                                class="menu-img">
                        </div>
                        <div class="menu-content">
                            <span class="menu-category">Fast Food</span>
                            <h4>Grilled Veg Sandwich</h4>
                            <p class="text-muted">Loaded with fresh vegetables, cheese, and our secret green chutney.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Menu Item 5 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="menu-card">
                        <div class="menu-img-wrapper">
                            <span class="menu-price">₹20</span>
                            <img src="<?php echo base_url('public/website/creamroll.png'); ?>" alt="Cream Roll"
                                class="menu-img">
                        </div>
                        <div class="menu-content">
                            <span class="menu-category">Bakery</span>
                            <h4>Fresh Cream Roll</h4>
                            <p class="text-muted">Crispy flaky pastry filled with sweet vanilla cream.</p>
                        </div>
                    </div>
                </div>

                <!-- Menu Item 6 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <div class="menu-card">
                        <div class="menu-img-wrapper">
                            <span class="menu-price">₹40</span>
                            <img src="<?php echo base_url('public/website/thick_coffee.png'); ?>" alt="Cold Coffee"
                                class="menu-img">
                        </div>
                        <div class="menu-content">
                            <span class="menu-category">Cold Beverage</span>
                            <h4>Thick Cold Coffee</h4>
                            <p class="text-muted">Creamy, blended cold coffee served chilled with chocolate syrup.</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-5">
                <a href="#" class="btn-custom">Download Full Menu</a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>Why Choose Us</h2>
                <p class="text-light mt-3">What makes Shiv Amruttulya the best choice for tea lovers.</p>
            </div>

            <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="100">
                    <div class="feature-box">
                        <i class="fas fa-mug-hot feature-icon"></i>
                        <h4>Freshly Brewed</h4>
                        <p>Every cup is freshly brewed on order to ensure maximum flavor and aroma.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="200">
                    <div class="feature-box">
                        <i class="fas fa-leaf feature-icon"></i>
                        <h4>Premium Leaves</h4>
                        <p>We source the finest tea leaves directly from the best tea gardens.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="300">
                    <div class="feature-box">
                        <i class="fas fa-stopwatch feature-icon"></i>
                        <h4>Fast Service</h4>
                        <p>Quick and efficient service without compromising on quality.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="400">
                    <div class="feature-box">
                        <i class="fas fa-pump-soap feature-icon"></i>
                        <h4>Hygienic Kitchen</h4>
                        <p>Strict hygiene protocols maintained in our kitchen and serving areas.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="500">
                    <div class="feature-box">
                        <i class="fas fa-tags feature-icon"></i>
                        <h4>Affordable Pricing</h4>
                        <p>Premium quality taste offered at pocket-friendly prices for everyone.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="600">
                    <div class="feature-box">
                        <i class="fas fa-users feature-icon"></i>
                        <h4>Family Friendly</h4>
                        <p>A warm, welcoming, and comfortable environment for families and friends.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Gallery Section -->
    <section id="gallery">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>Our Gallery</h2>
                <p class="text-muted mt-3">Glimpses of our authentic cafe experience.</p>
            </div>

            <div class="row" data-masonry='{"percentPosition": true }'>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <a href="<?php echo base_url('public/website/gallery_1.png'); ?>"
                        class="glightbox gallery-item d-block">
                        <img src="<?php echo base_url('public/website/gallery_1.png'); ?>" alt="Gallery Image"
                            class="img-fluid">
                        <div class="gallery-overlay">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <a href="<?php echo base_url('public/website/gallery_2.png'); ?>"
                        class="glightbox gallery-item d-block">
                        <img src="<?php echo base_url('public/website/gallery_2.png'); ?>" alt="Gallery Image"
                            class="img-fluid">
                        <div class="gallery-overlay">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <a href="<?php echo base_url('public/website/gallery_3.png'); ?>"
                        class="glightbox gallery-item d-block">
                        <img src="<?php echo base_url('public/website/gallery_3.png'); ?>" alt="Gallery Image"
                            class="img-fluid">
                        <div class="gallery-overlay">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <a href="<?php echo base_url('public/website/gallery_4.png'); ?>"
                        class="glightbox gallery-item d-block">
                        <img src="<?php echo base_url('public/website/gallery_4.png'); ?>" alt="Gallery Image"
                            class="img-fluid">
                        <div class="gallery-overlay">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <a href="<?php echo base_url('public/website/gallery_5.png'); ?>"
                        class="glightbox gallery-item d-block">
                        <img src="<?php echo base_url('public/website/gallery_5.png'); ?>" alt="Gallery Image"
                            class="img-fluid">
                        <div class="gallery-overlay">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                    <a href="<?php echo base_url('public/website/gallery_6.png'); ?>"
                        class="glightbox gallery-item d-block">
                        <img src="<?php echo base_url('public/website/gallery_6.png'); ?>" alt="Gallery Image"
                            class="img-fluid">
                        <div class="gallery-overlay">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Reviews Section -->
    <section id="reviews">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>Customer Reviews</h2>
                <p class="text-muted mt-3">Read what our happy customers have to say.</p>
            </div>

            <div class="swiper testimonials-slider" data-aos="fade-up" data-aos-delay="200">
                <div class="swiper-wrapper">
                    <!-- Testimonial 1 -->
                    <div class="swiper-slide">
                        <div class="testimonial-card">
                            <p class="testimonial-text">"Absolutely love the tea here! The authentic taste reminds me of
                                my hometown. The maska bun is a must-try with the special tea."</p>
                            <div class="client-info">
                                <img src="https://ui-avatars.com/api/?name=Rahul+Sharma&background=d4af37&color=fff"
                                    alt="Rahul" class="client-img">
                                <div class="client-details">
                                    <h5>Rahul Sharma</h5>
                                    <div class="stars">
                                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Testimonial 2 -->
                    <div class="swiper-slide">
                        <div class="testimonial-card">
                            <p class="testimonial-text">"Great ambiance and very hygienic place. Fast service and very
                                polite staff. The filter coffee is simply outstanding."</p>
                            <div class="client-info">
                                <img src="https://ui-avatars.com/api/?name=Priya+Patel&background=d4af37&color=fff"
                                    alt="Priya" class="client-img">
                                <div class="client-details">
                                    <h5>Priya Patel</h5>
                                    <div class="stars">
                                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star-half-alt"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Testimonial 3 -->
                    <div class="swiper-slide">
                        <div class="testimonial-card">
                            <p class="testimonial-text">"My daily morning stop! Shiv Amruttulya maintains consistent
                                taste and quality every single time. Highly recommended."</p>
                            <div class="client-info">
                                <img src="https://ui-avatars.com/api/?name=Amit+Kumar&background=d4af37&color=fff"
                                    alt="Amit" class="client-img">
                                <div class="client-details">
                                    <h5>Amit Kumar</h5>
                                    <div class="stars">
                                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Testimonial 4 -->
                    <div class="swiper-slide">
                        <div class="testimonial-card">
                            <p class="testimonial-text">"The best place for evening snacks. The grilled sandwich and
                                cold coffee combo is my absolute favorite. Very pocket friendly!"</p>
                            <div class="client-info">
                                <img src="https://ui-avatars.com/api/?name=Sneha+Desai&background=d4af37&color=fff"
                                    alt="Sneha" class="client-img">
                                <div class="client-details">
                                    <h5>Sneha Desai</h5>
                                    <div class="stars">
                                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="swiper-pagination mt-4 position-relative"></div>
            </div>
        </div>
    </section>

    <!-- Contact & Visit Section -->
    <section id="contact">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>Visit Our Shop</h2>
                <p class="text-muted mt-3">We'd love to serve you. Get in touch or visit us today.</p>
            </div>

            <div class="row g-5">
                <div class="col-lg-5" data-aos="fade-right">
                    <div class="contact-info-box">
                        <h4 class="mb-4">Contact Information</h4>

                        <div class="info-item">
                            <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
                            <div>
                                <h5>Location</h5>
                                <p class="text-muted mb-0">123, Main Market Road,<br>Pune, Maharashtra 411001</p>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-icon"><i class="fas fa-phone-alt"></i></div>
                            <div>
                                <h5>Call Us</h5>
                                <p class="text-muted mb-0">+91 98765 43210<br>+91 87654 32109</p>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-icon"><i class="fas fa-clock"></i></div>
                            <div>
                                <h5>Opening Hours</h5>
                                <p class="text-muted mb-0">Mon - Sun: 6:00 AM - 10:00 PM</p>
                            </div>
                        </div>

                        <div class="info-item mb-0">
                            <div class="info-icon"><i class="fas fa-envelope"></i></div>
                            <div>
                                <h5>Email</h5>
                                <p class="text-muted mb-0">hello@shivamruttulya.com</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-7" data-aos="fade-left">
                    <form class="contact-form">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" class="form-control" placeholder="Your Name" required>
                            </div>
                            <div class="col-md-6">
                                <input type="text" class="form-control" placeholder="Mobile Number" required>
                            </div>
                            <div class="col-12">
                                <input type="email" class="form-control" placeholder="Email Address">
                            </div>
                            <div class="col-12">
                                <textarea class="form-control" rows="5" placeholder="Your Message" required></textarea>
                            </div>
                            <div class="col-12 text-end">
                                <button type="submit" class="btn-custom border-0 w-100">Send Message</button>
                            </div>
                        </div>
                    </form>

                    <div class="map-container shadow-sm">
                        <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d121059.04360434078!2d73.7805654!3d18.5246036!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bc2bf2e67461101%3A0x828d43bf9d9ee343!2sPune%2C%20Maharashtra!5e0!3m2!1sen!2sin!4v1690000000000!5m2!1sen!2sin"
                            width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <a href="#" class="footer-logo mb-3">
                        <img src="<?php echo base_url('public/uploads/fav_shiv_amruttulya.png'); ?>"
                            alt="Shiv Amruttulya Logo" height="60">
                    </a>
                    <p class="footer-text mt-3">Experience the authentic taste of premium tea and delicious snacks.
                        Every sip tells a story of quality, tradition, and passion.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>

                <div class="col-lg-2 col-md-6 footer-links">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="#hero">Home</a></li>
                        <li><a href="#about">About Us</a></li>
                        <li><a href="#menu">Our Menu</a></li>
                        <li><a href="#features">Features</a></li>
                        <li><a href="#gallery">Gallery</a></li>
                    </ul>
                </div>

                <div class="col-lg-3 col-md-6 footer-links">
                    <h4>Legal</h4>
                    <ul>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms & Conditions</a></li>
                        <li><a href="#">Refund Policy</a></li>
                        <li><a href="#">Franchise Inquiry</a></li>
                    </ul>
                </div>

                <div class="col-lg-3 col-md-6 footer-links">
                    <h4>Franchise</h4>
                    <p class="footer-text">Interested in opening a Shiv Amruttulya franchise in your city?</p>
                    <a href="#" class="btn-custom" style="padding: 8px 20px; font-size: 0.9rem;">Apply Now</a>
                </div>
            </div>

            <div class="copyright d-flex flex-column flex-md-row justify-content-between align-items-center">
                <p class="mb-2 mb-md-0">&copy; <?php echo date('Y'); ?> Shiv Amruttulya. All Rights Reserved.</p>
                <p class="mb-0">Designed by <strong>Code Crafter</strong></p>
            </div>
        </div>
    </footer>

    <!-- Scroll Top Button -->
    <div id="scroll-top">
        <i class="fas fa-arrow-up"></i>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/mcstudios/glightbox/dist/js/glightbox.min.js"></script>
    <script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Preloader
            const preloader = document.getElementById('preloader');
            setTimeout(() => {
                preloader.style.opacity = '0';
                setTimeout(() => {
                    preloader.style.display = 'none';
                }, 500);
            }, 1000);

            // Init AOS
            AOS.init({
                duration: 1000,
                once: true,
                offset: 100,
            });

            // Navbar scroll effect
            const navbar = document.querySelector('.navbar');
            const scrollTopBtn = document.getElementById('scroll-top');

            window.addEventListener('scroll', () => {
                if (window.scrollY > 50) {
                    navbar.classList.add('scrolled');
                    scrollTopBtn.classList.add('active');
                } else {
                    navbar.classList.remove('scrolled');
                    scrollTopBtn.classList.remove('active');
                }
            });

            // Scroll to top
            scrollTopBtn.addEventListener('click', () => {
                window.scrollTo({ top: 0, behavior: 'smooth' });
            });

            // Testimonial Swiper
            new Swiper('.testimonials-slider', {
                speed: 600,
                loop: true,
                autoplay: {
                    delay: 5000,
                    disableOnInteraction: false
                },
                slidesPerView: 'auto',
                pagination: {
                    el: '.swiper-pagination',
                    type: 'bullets',
                    clickable: true
                },
                breakpoints: {
                    320: {
                        slidesPerView: 1,
                        spaceBetween: 20
                    },
                    768: {
                        slidesPerView: 2,
                        spaceBetween: 30
                    },
                    1200: {
                        slidesPerView: 3,
                        spaceBetween: 30
                    }
                }
            });

            // GLightbox
            const lightbox = GLightbox({
                selector: '.glightbox',
                touchNavigation: true,
                loop: true,
                autoplayVideos: true
            });
        });
    </script>
</body>

</html>