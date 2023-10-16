import React from 'react';
import ReactDOM from 'react-dom';
import SlideInTitle from './SlideInTitle';
import SlideInTitle2 from './SlideInTitle2';

document.addEventListener('DOMContentLoaded', () => {
    const titles = document.querySelectorAll('.react-root1');
    const titles2 = document.querySelectorAll('.react-root2');
    
    titles.forEach((title) => {
      const initialContent = title.innerHTML;
      ReactDOM.render(<SlideInTitle>{initialContent}</SlideInTitle>, title);
    });
  
    titles2.forEach((title2) => {
      const initialContent = title2.innerHTML;
      ReactDOM.render(<SlideInTitle2>{initialContent}</SlideInTitle2>, title2);
    });

  
});
