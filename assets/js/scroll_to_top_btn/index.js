const ScrollToTop = {
    mounted() {
      const scrollToTopBtn = this.el;
      if (!scrollToTopBtn) {
        console.warn('ScrollToTop element not found.');
        return;
      }
  
      scrollToTopBtn.addEventListener('click', () => {
        window.scrollTo({
          top: 0,
          behavior: 'smooth'
        });
      });
    }
  };

export default ScrollToTop;