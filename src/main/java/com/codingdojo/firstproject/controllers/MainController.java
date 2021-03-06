package com.codingdojo.firstproject.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.firstproject.models.Comment;
import com.codingdojo.firstproject.models.Item;
import com.codingdojo.firstproject.models.Order;
import com.codingdojo.firstproject.models.Payment;
import com.codingdojo.firstproject.models.User;
import com.codingdojo.firstproject.services.CommentService;
import com.codingdojo.firstproject.services.ItemService;
import com.codingdojo.firstproject.services.OrderService;
import com.codingdojo.firstproject.services.PaymentService;
import com.codingdojo.firstproject.services.UserService;
import com.codingdojo.firstproject.validation.UserValidator;

@Controller
public class MainController {
	@Autowired
	private final UserService userService;
	private final UserValidator userValidator;
	@Autowired
	private final OrderService orderService;
	@Autowired
	private final CommentService commentService;
	@Autowired
	private final ItemService itemService;
	@Autowired
	private final PaymentService paymentService;
	
	Boolean flag = true;

	public MainController (UserService userService, UserValidator userValidator, OrderService orderService, CommentService commentService, ItemService itemService, PaymentService paymentService) {
		this.userService=userService;
		this.userValidator=userValidator;
		this.commentService=commentService;
		this.itemService=itemService;
		this.orderService=orderService;
		this.paymentService=paymentService;
	}
	
	@GetMapping("/")
	public String index() {
		return "index.jsp";
	}
	
	@GetMapping("/EasyOrder/createUser")
	public String createUserPage(@ModelAttribute("user")User user, HttpSession session) {
		return "createUser.jsp";
	}
	
	@PostMapping("/EasyOrder/createUser")
	public String createUser(@Valid @ModelAttribute("user")User user, BindingResult result, HttpSession session) {
		userValidator.validate(user, result);
		if(result.hasErrors()) {
			return "createUser.jsp";
		}
		User newUser = userService.register(user);
		session.setAttribute("user_Id", newUser.getId());
		return "redirect:/EasyOrder.com";
	}
	
	@GetMapping("/EasyOrder/loginUser")
	public String loginUserPage(@ModelAttribute("user")User user, HttpSession session) {
		return "loginUser.jsp";
	}
	
	@PostMapping("/EasyOrder/loginUser")
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, HttpSession session, RedirectAttributes redirectAttr) {
		if(!this.userService.authenicateUser(email, password)) {
			redirectAttr.addFlashAttribute("error", "Invalid Email or password");
			return "redirect:/EasyOrder/loginUser";
		}
		User loginUser = this.userService.getByEmail(email);
		session.setAttribute("user_Id", loginUser.getId());
		return "redirect:/EasyOrder.com";
	}
	
	@GetMapping("/EasyOrder.com")
	public String homepage(HttpSession session, Model viewModel, @ModelAttribute("newOrder")Order order) {
			Long userId = (Long) session.getAttribute("user_Id");
			User loginUser= userService.getOneUser(userId);
			viewModel.addAttribute("user", loginUser);
			List<Order> userOrders = loginUser.getOrders();
			viewModel.addAttribute("orders",userOrders);
			for (Order oneOrder : userOrders) {
				if(oneOrder.getPaid().equals(false)) {
					Order notPaidOrder = oneOrder;
					viewModel.addAttribute("order", notPaidOrder);
				}
			}
			return "homepage.jsp";
	}
	
	@GetMapping("/EasyOrder.com/editUser/{id}")
	public String editUser(@PathVariable("id")Long id, Model viewModel, @ModelAttribute("user")User user) {
		viewModel.addAttribute("user", this.userService.getOneUser(id));
		return "editUser.jsp";
	}
	
	@PostMapping("/EasyOrder.com/editUser/{id}")
	public String updateUser(@Valid @ModelAttribute("user")User user, BindingResult result, @PathVariable("id")Long id, Model viewModel ) {
		if(result.hasErrors()) {
			
			return "editUser.jsp";
		}
		this.userService.editUser(user);
		return "redirect:/EasyOrder.com";
	}
	
	@PostMapping("/EasyOrder.com/newOrder")
	public String createOrder(@Valid @ModelAttribute("newOrder")Order order,BindingResult result, Model viewModel) {
		if (result.hasErrors()) {
			return "redirect:/EasyOrder.com";
		}
		Random orderNumber = new Random();
		Number newRandomNumber = Math.abs(orderNumber.nextInt());
		order.setOrderNumber(newRandomNumber);
		this.orderService.createOrder(order);
		Long orderId = order.getId();
		return "redirect:/EasyOrder.com/newOrder/"+orderId;
	}
	
	@GetMapping("/EasyOrder.com/newOrder/{id}")
	public String startOrder(HttpSession session, Model viewModel, @ModelAttribute("item")Item item, @PathVariable("id")Long orderId) {
		Long userId = (Long)session.getAttribute("user_Id");
		User loginUser = userService.getOneUser(userId);
		//Anna(Daily Special):
		String[] weekdays = {"Monday","Tuesday", "Wednesday","Thursday","Friday"};
		String currentDay = this.itemService.currDay();	
		viewModel.addAttribute("user", loginUser);
		viewModel.addAttribute("order", this.orderService.getOne(orderId));
		viewModel.addAttribute("allItems", this.itemService.byCategory());
		viewModel.addAttribute("weekdaySpecials", this.itemService.weekdaySpecials());
		viewModel.addAttribute("weekday",weekdays);
		viewModel.addAttribute("currentDay",currentDay);
		return "newOrder.jsp";
	}
	
	
	//Added code by Anna
	@GetMapping("/EasyOrder.com/newOrder/{id}/priceAsc")
	public String startOrderPriceAsc(HttpSession session, Model viewModel, @ModelAttribute("item")Item item, @PathVariable("id")Long orderId) {
		Long userId = (Long)session.getAttribute("user_Id");
		User loginUser = userService.getOneUser(userId);
		String[] weekdays = {"Monday","Tuesday", "Wednesday","Thursday","Friday"};
		String currentDay = this.itemService.currDay();	
		viewModel.addAttribute("user", loginUser);
		viewModel.addAttribute("order", this.orderService.getOne(orderId));
		viewModel.addAttribute("weekdaySpecials", this.itemService.weekdaySpecials());
		viewModel.addAttribute("weekday",weekdays);
		viewModel.addAttribute("currentDay",currentDay);
		viewModel.addAttribute("allItems", this.itemService.byPriceAscended());
		return "newOrder.jsp";
	}
		
	//Added code by Anna
	@GetMapping("/EasyOrder.com/newOrder/{id}/priceDesc")
	public String startOrderPriceDes(HttpSession session, Model viewModel, @ModelAttribute("item")Item item, @PathVariable("id")Long orderId) {
		Long userId = (Long)session.getAttribute("user_Id");
		User loginUser = userService.getOneUser(userId);
		String[] weekdays = {"Monday","Tuesday", "Wednesday","Thursday","Friday"};
		String currentDay = this.itemService.currDay();	
		viewModel.addAttribute("user", loginUser);
		viewModel.addAttribute("order", this.orderService.getOne(orderId));
		viewModel.addAttribute("weekdaySpecials", this.itemService.weekdaySpecials());
		viewModel.addAttribute("weekday",weekdays);
		viewModel.addAttribute("currentDay",currentDay);
		viewModel.addAttribute("allItems", this.itemService.byPriceDescended());
		return "newOrder.jsp";
	}
	
	@GetMapping("/EasyOrder.com/newOrder/{orderId}/special/{id}")
	public String addSpecial(@PathVariable("orderId")Long orderId, @PathVariable("id")Long itemId, Model viewModel, @ModelAttribute("item")Item item) {
		Item special = this.itemService.getOne(itemId);
		Order currentOrder = this.orderService.getOne(orderId);
		viewModel.addAttribute("order", currentOrder);
		this.orderService.addSpecialInOrder(currentOrder, special);
		return "redirect:/EasyOrder.com/newOrder/"+orderId;
	}
	
	@GetMapping("/EasyOrder.com/newOrder/{orderId}/removeSpecial/{id}")
	public String removeSpecial(@PathVariable("orderId")Long orderId, @PathVariable("id")Long itemId, Model viewModel) {
		Item special = this.itemService.getOne(itemId);
		Order currentOrder = this.orderService.getOne(orderId);
		viewModel.addAttribute("order", currentOrder);
		this.orderService.removeSpecialInOrder(currentOrder, special);
		currentOrder.setHasSpecial(false);
		return "redirect:/EasyOrder.com/newOrder/"+orderId;
	}

	@GetMapping("/EasyOrder.com/newOrder/{orderId}/{id}")
	public String addToCart(HttpSession session, @PathVariable("orderId")Long orderId, @PathVariable("id")Long itemId, Model viewModel, @ModelAttribute("item")Item item) {
		Item newItem = this.itemService.getOne(itemId);
		Order currentOrder = this.orderService.getOne(orderId);
		viewModel.addAttribute("order", currentOrder);
		this.orderService.addItemInOrder(currentOrder, newItem);
		return "redirect:/EasyOrder.com/newOrder/"+orderId;
	}
		
	@GetMapping("/EasyOrder.com/newOrder/{orderId}/remove/{id}")
	public String removeFromCart(HttpSession session,@PathVariable("orderId")Long orderId, @PathVariable("id")Long itemId, Model viewModel) {
		Item newItem = this.itemService.getOne(itemId);
		Order currentOrder = this.orderService.getOne(orderId);
		viewModel.addAttribute("order", currentOrder);
		this.orderService.removeItemInOrder(currentOrder, newItem);
		return "redirect:/EasyOrder.com/newOrder/"+orderId;
	}
	
	@GetMapping("/EasyOrder.com/newOrder/{id}/starOver")
	public String starOver(HttpSession session, @PathVariable("id")Long orderId, Model viewModel) {
		Order currentOrder = this.orderService.getOne(orderId);
		for(Item item : currentOrder.getOrderItems()) {
			itemService.defaultingItemQ(item);
		}
		orderService.removeAllItemsInOrder(currentOrder);
		return "redirect:/EasyOrder.com/newOrder/"+orderId;
	}
	
	@GetMapping("/EasyOrder.com/{id}/CheckOut")
	public String checkOut(HttpSession session, Model viewModel, @ModelAttribute("order")Order order, @PathVariable("id")Long orderId) {
		Long userId = (Long)session.getAttribute("user_Id");
		User loginUser = userService.getOneUser(userId);
		viewModel.addAttribute("user", loginUser);
		Order currentOrder = orderService.getOne(orderId);
		Number orderNumber = currentOrder.getOrderNumber();
		if (currentOrder.getHasSpecial() == true) {
			Double discountToApply = currentOrder.getTotal();
			Double discount = Math.round((discountToApply*0.1)*100.0)/100.00;
			Double total = Math.round((discountToApply*0.9)*100.0)/100.00;
			viewModel.addAttribute("discount",discount);
			viewModel.addAttribute("total", total);
		}else {
			Double total = currentOrder.getTotal();
			viewModel.addAttribute("total", total);
		}
		Map<Item, Integer>countMap = new HashMap<>();
		List<Item> allItems = this.itemService.allItems();
		for (Item item: currentOrder.getOrderItems()) {
		      if (countMap.containsKey(item))
		          countMap.put(item, countMap.get(item) + 1);
		      else
		          countMap.put(item, 1);
		  	}
		viewModel.addAttribute("allItems", allItems);
		viewModel.addAttribute("countMap", countMap);
		viewModel.addAttribute("order",currentOrder);
		viewModel.addAttribute("orderNumber", orderNumber);
		return "checkOut.jsp";
	}
	
	@PostMapping("/EasyOrder.com/{id}/CheckOut")
	public String postOrder(Model viewModel, @PathVariable("id")Long orderId) {
		Order order = orderService.getOne(orderId);
		if (order.getHasSpecial() == true) {
			Double discountToApply = order.getTotal();
			Double total = Math.round((discountToApply*0.9)*100.0)/100.00;
			orderService.disCountApply(order, total);
		}
    
		//Updated code by Archana
		return "redirect:/EasyOrder.com/"+orderId+"/checkout/payment";
	}
	
	@GetMapping("/EasyOrder.com/order/{id}")
	public String orderDetail(@PathVariable("id")Long id, Model viewModel, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_Id");
		User loginUser = userService.getOneUser(userId);
		Order selectedOrder = orderService.getOne(id);
		Map<Item, Integer>countMap = new HashMap<>();
		for (Item item: selectedOrder.getOrderItems()) {
		      if (countMap.containsKey(item))
		          countMap.put(item, countMap.get(item) + 1);
		      else
		          countMap.put(item, 1);
		  }
		viewModel.addAttribute("total", selectedOrder.getTotal());
		viewModel.addAttribute("countMap", countMap);
		viewModel.addAttribute("order", selectedOrder);
		viewModel.addAttribute("user", loginUser);
		return "orderDetail.jsp";
	}
	
	// Added the payment get
	//"/EasyOrder.com/{id}/CheckOut"
	 
	@GetMapping("/EasyOrder.com/{id}/checkout/payment")
	public String paymentOrder(@ModelAttribute("payment") Payment payment,@PathVariable("id") Long orderId,BindingResult result,Model model,HttpSession session) {
		User user= this.userService.getOneUser((Long)session.getAttribute("user_Id"));
		model.addAttribute("user", user);
		List<Payment> userPayments=user.getPaymentByUser();
		
		//model.addAttribute("pizza", this.pService.getOnePizza(id));
		model.addAttribute("order", this.orderService.getOne(orderId));
		model.addAttribute("payments",userPayments);
		return "payment.jsp";
	}
	
	@PostMapping("/EasyOrder.com/{id}/checkout/payment")
	public String paymentOrderPost(@Valid@ModelAttribute("payment") Payment payment,@PathVariable("id") Long orderId,BindingResult result,Model model,HttpSession session){
		
		if(result.hasErrors()) {
		User user= this.userService.getOneUser((Long)session.getAttribute("user_Id"));
		//model.addAttribute("pizza", this.pService.getOnePizza(id));
		model.addAttribute("order", this.orderService.getOne(orderId));

		return "payment.jsp";
		}
		
		// user who makePayment
		User user= this.userService.getOneUser((Long)session.getAttribute("user_Id"));
		// create a payment
		
		this.payService.createPayment(payment);
		//return "redirect:/orders/continue";
		return "redirect:/EasyOrder.com/"+orderId+"/success";

	
	}


	@GetMapping("/continue")
	public String countinueFoody() {
		return "continue.jsp";
	}

	
	
	
	@GetMapping("/EasyOrder.com/delete/{id}")
	public String deleteOrder(@PathVariable("id")Long id) {
		Order orderToDelete = this.orderService.getOne(id);
		for(Item item : orderToDelete.getOrderItems()) {
			itemService.defaultingItemQ(item);
		}
		this.orderService.deleteOrder(id);
		return "redirect:/EasyOrder.com";
	}
	
	//Added code by Archana
	@GetMapping("/EasyOrder.com/{id}/checkout/payment")
	public String paymentOrder(@ModelAttribute("payment")Payment payment,@PathVariable("id") Long orderId,BindingResult result,Model model,HttpSession session) {
		User user= this.userService.getOneUser((Long)session.getAttribute("user_Id"));
		model.addAttribute("user", user);
		List<Payment> userPayments = user.getUserPayments();
		model.addAttribute("order", this.orderService.getOne(orderId));
		model.addAttribute("payments", userPayments);
		return "payment.jsp";
	}
	
	//Added code by Archana
	@PostMapping("/EasyOrder.com/{id}/checkout/payment")
	public String paymentOrderPost(@Valid @ModelAttribute("payment")Payment payment,BindingResult result, @PathVariable("id") Long orderId, Model model, HttpSession session){
		if(result.hasErrors()) {
			User user= this.userService.getOneUser((Long)session.getAttribute("user_Id"));
			model.addAttribute("user", user);
			List<Payment> userPayments = user.getUserPayments();
			model.addAttribute("order", this.orderService.getOne(orderId));
			model.addAttribute("payments", userPayments);
			return "payment.jsp";
		}
		// create a payment
		this.paymentService.createPayment(payment);
		return "redirect:/EasyOrder.com/"+orderId+"/checkout/payment";
	}
	
	//Added code by Archana
	@GetMapping("/EasyOrder.com/{id}/checkout/savedCard/{paymentId}")
	public String checkOutWithSavedCard(@PathVariable("id")Long id, @PathVariable("paymentId")Long paymentId) {
		Order orderPaid = this.orderService.getOne(id);
		Payment saveCard = this.paymentService.getOne(paymentId);
		orderPaid.setOrderPayment(saveCard);
		this.orderService.updateOrder(orderPaid);
		for(Item item : orderPaid.getOrderItems()) {
			itemService.defaultingItemQ(item);
		}
		return "redirect:/EasyOrder.com/"+id+"/success";
	}
	//Added code by Archana
//	@GetMapping("/EasyOrder.com/{orderId}/deletePayment/{id}")
//	public String deletePayment(@PathVariable("id")Long id, @PathVariable("orderId")Long orderId) {
//		paymentService.deletePayment(id);
//		return "redirect:/EasyOrder.com/"+orderId+"/checkout/payment";
//		
//	}
	
	//Updated code by Archana
	@GetMapping("/EasyOrder.com/{id}/success")
	public String placeOrder(HttpSession session, Model viewModel, @PathVariable("id")Long orderId) {
		Long userId = (Long)session.getAttribute("user_Id");
		Order newOrder = orderService.getOne(orderId);
		Number orderNumber = newOrder.getOrderNumber();
		User loginUser = userService.getOneUser(userId);
		Map<Item, Integer>countMap = new HashMap<>();
		for (Item item: newOrder.getOrderItems()) {
		      if (countMap.containsKey(item))
		          countMap.put(item, countMap.get(item) + 1);
		      else
		          countMap.put(item, 1);
		  }
		viewModel.addAttribute("countMap", countMap);
		viewModel.addAttribute("order", newOrder);
		viewModel.addAttribute("orderNumber", orderNumber);
		viewModel.addAttribute("user", loginUser);
		return "success.jsp";
	}
	

	//Updated code by Anna
	@GetMapping("/EasyOrder.com/commentWall")
	public String showComment(HttpSession session, Model viewModel, @ModelAttribute("newComment")Comment newComment) {
		Long userId = (Long)session.getAttribute("user_Id");
		User loginUser = userService.getOneUser(userId);
		List<Comment> userComment = loginUser.getComments();
		viewModel.addAttribute("user", loginUser);
		if (flag == true) {
			viewModel.addAttribute("allComments", commentService.allComments());
		}
		if (flag == false) {
			viewModel.addAttribute("allComments", userComment);
		}
		return "comment.jsp";
	}
	//Added code by Anna
	@PostMapping("/EasyOrder.com/commentWall/user")
	public String postUserComment(@Valid @ModelAttribute("newComment")Comment newComment, BindingResult result, HttpSession session, Model viewModel) {
		flag = false;
		return "redirect:/EasyOrder.com/commentWall";
	}
	//Added code by Anna
	@PostMapping("/EasyOrder.com/commentWall/reset")
	public String postResetComment(@Valid @ModelAttribute("newComment")Comment newComment, BindingResult result, HttpSession session, Model viewModel) {
		flag = true;
		return "redirect:/EasyOrder.com/commentWall";
	}

	
	//Added code by Anna
	@PostMapping("/EasyOrder.com/commentWall/user")
	public String postUserComment(@Valid @ModelAttribute("newComment")Comment newComment, BindingResult result, HttpSession session, Model viewModel) {
		flag = false;
		return "redirect:/EasyOrder.com/commentWall";
	}
	
	//Added code by Anna
	@PostMapping("/EasyOrder.com/commentWall/reset")
	public String postResetComment(@Valid @ModelAttribute("newComment")Comment newComment, BindingResult result, HttpSession session, Model viewModel) {
		flag = true;
		return "redirect:/EasyOrder.com/commentWall";
	}
	
	@PostMapping("/EasyOrder.com/commentWall")
	public String postComment(@Valid @ModelAttribute("comment")Comment newComment, BindingResult result, HttpSession session, Model viewModel) {
		if(result.hasErrors()) {
			Long userId = (Long)session.getAttribute("user_Id");
			User loginUser = this.userService.getOneUser(userId);
			viewModel.addAttribute("user", loginUser);
			return "comment.jsp";
		}
		this.commentService.createComment(newComment);
		return "redirect:/EasyOrder.com/commentWall";
	}
	
	@GetMapping("/EasyOrder.com/{id}/like")
	public String likeComment(HttpSession session,@PathVariable("id") Long commentId) {
		Long userId = (Long)session.getAttribute("user_Id");
		User userlike = this.userService.getOneUser(userId);
		Comment likeComment = this.commentService.getOne(commentId);
		this.commentService.likeComment(likeComment, userlike);
		return "redirect:/EasyOrder.com/commentWall";
	}
	
	@GetMapping("/EasyOrder.com/{id}/cancelLike")
	public String cancelLike(HttpSession session,@PathVariable("id") Long commentId) {
		Long userId = (Long)session.getAttribute("user_Id");
		User userlike = this.userService.getOneUser(userId);
		Comment likeComment = this.commentService.getOne(commentId);
		this.commentService.cancelLike(likeComment, userlike);
		return "redirect:/EasyOrder.com/commentWall";
	}
	
	@GetMapping("/EasyOrder.com/{id}/delete")
	public String deleteComment(@PathVariable("id")Long commentId) {
		this.commentService.deleteComment(commentId);
		return "redirect:/EasyOrder.com/commentWall";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
