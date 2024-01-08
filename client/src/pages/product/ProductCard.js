/*import React from "react";*/
import { useLocation, useNavigate } from 'react-router-dom';
import {
  Button,
  Typography,
  CardMedia,
  CardContent,
  CardActions,
  Card,
} from "@material-ui/core";

const ProductCard = ({ product }) => {
    const location = useLocation();
    let navigate = useNavigate();
    const currentPath = location.pathname // to get current route
    const handleClick = (prodid) => {
        //alert(prodid);
        navigate(`${currentPath}/${prodid}`)
    }

    console.log("inside productcard" + JSON.stringify(product));
    return (

    <Card sx={{ maxWidth: 345 }}>
      <CardMedia
                sx={{ height: 140 }}
                image="/static/images/cards/contemplative-reptile.jpg"
                title={product.title}
      />
      <CardContent>
        <Typography gutterBottom variant="h5" component="div">
                    {product.title}
        </Typography>
                <Typography variant="body2" color="text.secondary">
                    {product.description}
        </Typography>
      </CardContent>
      <CardActions>
                <Button size="small" href={`${currentPath}/${product.id}`} >View</Button> 
        <Button size="small">Learn More</Button>
      </CardActions>
    </Card>
  );
};

export default ProductCard;
