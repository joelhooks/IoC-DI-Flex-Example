/*
	Inversion of Control/Dependency Injection Using Parsley
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package com.joelhooks.parsley.example.controllers
{
	import com.joelhooks.parsley.example.events.GalleryImageEvent;
	import com.joelhooks.parsley.example.models.presentation.IGalleryPresentationModel;
	import com.joelhooks.parsley.example.models.vo.GalleryImage;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class SelectImageAction extends EventDispatcher
	{
		[Inject(id="galleryPresentationModel")]
		public var galleryPresentationModel:IGalleryPresentationModel;
		
		public function SelectImageAction(target:IEventDispatcher=null)
		{
			super(target);
		}

		[MessageHandler(selector="selectGalleryImage")]
		public function handleSelectImage(event:GalleryImageEvent):void
		{
			if(event.image)
				this.galleryPresentationModel.selectedImage = event.image;
			else if(this.galleryPresentationModel.gallery.photos.length>0)
				this.galleryPresentationModel.selectedImage = this.galleryPresentationModel.gallery.photos[0];
			
			for each(var image:GalleryImage in this.galleryPresentationModel.gallery.photos)
			{
				image.selected = image == this.galleryPresentationModel.selectedImage;
			}
		}
	}
}