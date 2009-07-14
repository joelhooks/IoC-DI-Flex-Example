/*
	Inversion of Control/Dependency Injection Using Parsley
	Image Gallery
	
	Any portion of this demonstration may be reused for any purpose where not 
	licensed by another party restricting such use. Please leave the credits intact.
	
	Joel Hooks
	http://joelhooks.com
	joelhooks@gmail.com 
*/
package com.joelhooks.parsley.example.delegates
{
	import com.adobe.webapis.flickr.FlickrService;
	import com.adobe.webapis.flickr.Photo;
	import com.adobe.webapis.flickr.events.FlickrResultEvent;
	import com.adobe.webapis.flickr.methodgroups.Photos;
	import com.adobe.webapis.flickr.methodgroups.helpers.PhotoSearchParams;
	import com.joelhooks.parsley.example.events.GalleryEvent;
	import com.joelhooks.parsley.example.events.GalleryImageServiceEvent;
	import com.joelhooks.parsley.example.models.vo.Gallery;
	import com.joelhooks.parsley.example.models.vo.GalleryImage;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	[Event(name="serviceReady", type="com.joelhooks.parsley.example.events.GalleryImageServiceEvent")]
	[Event(name="galleryLoaded",type="com.joelhooks.parsley.example.events.GalleryEvent")]
	[ManagedEvents("galleryLoaded,serviceReady")]
	public class FlickrImageServiceDelegate extends EventDispatcher implements IGalleryImageServiceDelegate
	{
		private var service:FlickrService;
		private var photos:Photos;
		
		public var apiKey:String;
		public var secret:String;
		public var NSID:String;

		public function FlickrImageServiceDelegate()
		{
		}
		
		[PostConstruct]
		public function init():void
		{
			trace("Configuring Service");
			this.service = new FlickrService(this.apiKey);
			this.photos = new Photos(this.service);
			this.dispatchEvent(new GalleryImageServiceEvent(GalleryImageServiceEvent.SERVICE_READY));
		}

		public function loadGallery():void
		{
			service.addEventListener(FlickrResultEvent.INTERESTINGNESS_GET_LIST, handleSearchResult);
			service.interestingness.getList()
		}
		
		protected function handleSearchResult(event:FlickrResultEvent):void
		{
			this.processFlickrPhotoResults(event.data.photos.photos);
		}
		
		protected function processFlickrPhotoResults(results:Array):void
		{
			var gallery:Gallery = new Gallery();
			gallery.photos = new ArrayCollection();
			for each(var flickrPhoto:Photo in results)
			{
				var photo:GalleryImage = new GalleryImage()
				var baseURL:String = 'http://farm' + flickrPhoto.farmId + '.static.flickr.com/' + flickrPhoto.server + '/' + flickrPhoto.id + '_' + flickrPhoto.secret;
				photo.thumbURL = baseURL + '_s.jpg';
				photo.URL = baseURL + '.jpg';
				gallery.photos.addItem( photo );
			}
			
			this.dispatchEvent(new GalleryEvent(GalleryEvent.GALLERY_LOADED, gallery));
		}
		
		public function handleLoadGalleryComplete(event:Event):void
		{
		}
		
		public function handleLoadImageComplete(event:Event):void
		{
		}
	}
}