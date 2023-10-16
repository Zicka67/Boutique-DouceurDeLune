import React, { useEffect, useRef } from 'react';
import { motion } from 'framer-motion';

const SlideInTitle = ({ children }) => {
  const ref = useRef(null);

  useEffect(() => {
    if (ref.current) {
      ref.current.style.visibility = 'visible';
    }
  }, []);

  return (
    <motion.h1
      ref={ref}
      initial={{ opacity: 0, x: 500 }}
      animate={{ opacity: 1, x: 0 }}
      transition={{ duration: 1.5, ease: "easeInOut" }}
    >
      {children}
    </motion.h1>
  );
};

export default SlideInTitle;
