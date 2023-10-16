import React, { useEffect, useRef } from 'react';
import { motion, useAnimation } from 'framer-motion';

const FramerMotion1 = ({ initialContent }) => {
  const controls = useAnimation();
  const ref = useRef(null);

  const checkIfVisible = () => {
    const rect = ref.current.getBoundingClientRect();
    if (rect.top <= window.innerHeight && rect.bottom >= 0) {
      controls.start("visible");
      window.removeEventListener('scroll', checkIfVisible);
    }
  };

  useEffect(() => {
    window.addEventListener('scroll', checkIfVisible);
    checkIfVisible();
    return () => {
      window.removeEventListener('scroll', checkIfVisible);
    };
  }, []);

  return (
    <motion.h1
      ref={ref}
      initial="hidden"
      animate={controls}
      variants={{
        visible: { opacity: 1, x: 0 },
        hidden: { opacity: 0, x: 500 },
      }}
      transition={{ duration: 1.5, ease: "easeInOut" }}
      dangerouslySetInnerHTML={{ __html: initialContent }} 
    >
    </motion.h1>
  );
};

export default FramerMotion1;
