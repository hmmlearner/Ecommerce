import React, { useState, useEffect, useImperativeHandle, forwardRef, useRef } from 'react';
import Box from '@mui/material/Box';
import Cart from './Cart';
import Typography from '@mui/material/Typography';
import {Button, Modal, Backdrop, Fade } from '@material-ui/core'

const style = {
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    width: 400,
    bgcolor: 'background.paper',
    border: '2px solid #000',
    boxShadow: 24,
    p: 4,
};

const CartModal = forwardRef(({ cartOpen }, ref) => {

    const modal = useRef();

    useImperativeHandle(ref, () => {
        return {
            onOpen: () => {
                setOpen(true);
            },
       
        };
    });

    const [open, setOpen] = useState(false);

    const handleClose = () => setOpen(false);


    return (
        <div>

            <Modal
                open={open}
                onClose={handleClose}
                aria-labelledby="modal-modal-title"
                aria-describedby="modal-modal-description"
                ref={modal}
            >
                <Box sx={style}>
                    <Cart />
                    <Button onClick={handleClose}>Close</Button>
                </Box>

            </Modal>
        </div>
    );
});

export default CartModal;