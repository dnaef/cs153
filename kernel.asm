
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 00 2f 10 80       	mov    $0x80102f00,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
	...

80100040 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	56                   	push   %esi
80100044:	53                   	push   %ebx
80100045:	83 ec 10             	sub    $0x10,%esp
80100048:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
8010004b:	8d 73 0c             	lea    0xc(%ebx),%esi
8010004e:	89 34 24             	mov    %esi,(%esp)
80100051:	e8 9a 42 00 00       	call   801042f0 <holdingsleep>
80100056:	85 c0                	test   %eax,%eax
80100058:	74 62                	je     801000bc <brelse+0x7c>
    panic("brelse");

  releasesleep(&b->lock);
8010005a:	89 34 24             	mov    %esi,(%esp)
8010005d:	e8 be 42 00 00       	call   80104320 <releasesleep>

  acquire(&bcache.lock);
80100062:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100069:	e8 22 45 00 00       	call   80104590 <acquire>
  b->refcnt--;
8010006e:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100071:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100074:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100076:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
80100079:	75 2f                	jne    801000aa <brelse+0x6a>
    // no one is waiting for it.
    b->next->prev = b->prev;
8010007b:	8b 43 54             	mov    0x54(%ebx),%eax
8010007e:	8b 53 50             	mov    0x50(%ebx),%edx
80100081:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100084:	8b 43 50             	mov    0x50(%ebx),%eax
80100087:	8b 53 54             	mov    0x54(%ebx),%edx
8010008a:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010008d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
80100092:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
80100099:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
8010009c:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
801000a1:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000a4:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
801000aa:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
801000b1:	83 c4 10             	add    $0x10,%esp
801000b4:	5b                   	pop    %ebx
801000b5:	5e                   	pop    %esi
801000b6:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
801000b7:	e9 84 44 00 00       	jmp    80104540 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
801000bc:	c7 04 24 c0 71 10 80 	movl   $0x801071c0,(%esp)
801000c3:	e8 08 03 00 00       	call   801003d0 <panic>
801000c8:	90                   	nop
801000c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801000d0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	53                   	push   %ebx
801000d4:	83 ec 14             	sub    $0x14,%esp
801000d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801000da:	8d 43 0c             	lea    0xc(%ebx),%eax
801000dd:	89 04 24             	mov    %eax,(%esp)
801000e0:	e8 0b 42 00 00       	call   801042f0 <holdingsleep>
801000e5:	85 c0                	test   %eax,%eax
801000e7:	74 10                	je     801000f9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801000e9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801000ec:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801000ef:	83 c4 14             	add    $0x14,%esp
801000f2:	5b                   	pop    %ebx
801000f3:	5d                   	pop    %ebp
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801000f4:	e9 57 1f 00 00       	jmp    80102050 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801000f9:	c7 04 24 c7 71 10 80 	movl   $0x801071c7,(%esp)
80100100:	e8 cb 02 00 00       	call   801003d0 <panic>
80100105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100110 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
80100110:	55                   	push   %ebp
80100111:	89 e5                	mov    %esp,%ebp
80100113:	57                   	push   %edi
80100114:	56                   	push   %esi
80100115:	53                   	push   %ebx
80100116:	83 ec 1c             	sub    $0x1c,%esp
80100119:	8b 75 08             	mov    0x8(%ebp),%esi
8010011c:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
8010011f:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100126:	e8 65 44 00 00       	call   80104590 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010012b:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
80100131:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100137:	75 12                	jne    8010014b <bread+0x3b>
80100139:	eb 25                	jmp    80100160 <bread+0x50>
8010013b:	90                   	nop
8010013c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100140:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100143:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100149:	74 15                	je     80100160 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010014b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010014e:	75 f0                	jne    80100140 <bread+0x30>
80100150:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100153:	75 eb                	jne    80100140 <bread+0x30>
      b->refcnt++;
80100155:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100159:	eb 3f                	jmp    8010019a <bread+0x8a>
8010015b:	90                   	nop
8010015c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100160:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100166:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010016c:	75 0d                	jne    8010017b <bread+0x6b>
8010016e:	eb 58                	jmp    801001c8 <bread+0xb8>
80100170:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100173:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100179:	74 4d                	je     801001c8 <bread+0xb8>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010017b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010017e:	85 c0                	test   %eax,%eax
80100180:	75 ee                	jne    80100170 <bread+0x60>
80100182:	f6 03 04             	testb  $0x4,(%ebx)
80100185:	75 e9                	jne    80100170 <bread+0x60>
      b->dev = dev;
80100187:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010018a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010018d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100193:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010019a:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
801001a1:	e8 9a 43 00 00       	call   80104540 <release>
      acquiresleep(&b->lock);
801001a6:	8d 43 0c             	lea    0xc(%ebx),%eax
801001a9:	89 04 24             	mov    %eax,(%esp)
801001ac:	e8 af 41 00 00       	call   80104360 <acquiresleep>
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
801001b1:	f6 03 02             	testb  $0x2,(%ebx)
801001b4:	75 08                	jne    801001be <bread+0xae>
    iderw(b);
801001b6:	89 1c 24             	mov    %ebx,(%esp)
801001b9:	e8 92 1e 00 00       	call   80102050 <iderw>
  }
  return b;
}
801001be:	83 c4 1c             	add    $0x1c,%esp
801001c1:	89 d8                	mov    %ebx,%eax
801001c3:	5b                   	pop    %ebx
801001c4:	5e                   	pop    %esi
801001c5:	5f                   	pop    %edi
801001c6:	5d                   	pop    %ebp
801001c7:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001c8:	c7 04 24 ce 71 10 80 	movl   $0x801071ce,(%esp)
801001cf:	e8 fc 01 00 00       	call   801003d0 <panic>
801001d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801001da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001e0 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	53                   	push   %ebx
  // head.next is most recently used.
  struct buf head;
} bcache;

void
binit(void)
801001e4:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
{
801001e9:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
801001ec:	c7 44 24 04 df 71 10 	movl   $0x801071df,0x4(%esp)
801001f3:	80 
801001f4:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
801001fb:	e8 00 42 00 00       	call   80104400 <initlock>
  // head.next is most recently used.
  struct buf head;
} bcache;

void
binit(void)
80100200:	b8 dc fc 10 80       	mov    $0x8010fcdc,%eax

  initlock(&bcache.lock, "bcache");

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100205:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
8010020c:	fc 10 80 
  bcache.head.next = &bcache.head;
8010020f:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
80100216:	fc 10 80 
80100219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100220:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100223:	8d 43 0c             	lea    0xc(%ebx),%eax
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
80100226:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
8010022d:	89 04 24             	mov    %eax,(%esp)
80100230:	c7 44 24 04 e6 71 10 	movl   $0x801071e6,0x4(%esp)
80100237:	80 
80100238:	e8 83 41 00 00       	call   801043c0 <initsleeplock>
    bcache.head.next->prev = b;
8010023d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
80100242:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100245:	89 d8                	mov    %ebx,%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
80100247:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010024d:	81 c3 5c 02 00 00    	add    $0x25c,%ebx
80100253:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100259:	75 c5                	jne    80100220 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
8010025b:	83 c4 14             	add    $0x14,%esp
8010025e:	5b                   	pop    %ebx
8010025f:	5d                   	pop    %ebp
80100260:	c3                   	ret    
	...

80100270 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100276:	c7 44 24 04 ed 71 10 	movl   $0x801071ed,0x4(%esp)
8010027d:	80 
8010027e:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100285:	e8 76 41 00 00       	call   80104400 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
8010028a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100291:	c7 05 8c 09 11 80 d0 	movl   $0x801005d0,0x8011098c
80100298:	05 10 80 
  devsw[CONSOLE].read = consoleread;
8010029b:	c7 05 88 09 11 80 d0 	movl   $0x801002d0,0x80110988
801002a2:	02 10 80 
  cons.locking = 1;
801002a5:	c7 05 74 a5 10 80 01 	movl   $0x1,0x8010a574
801002ac:	00 00 00 

  picenable(IRQ_KBD);
801002af:	e8 0c 30 00 00       	call   801032c0 <picenable>
  ioapicenable(IRQ_KBD, 0);
801002b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801002bb:	00 
801002bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801002c3:	e8 88 1f 00 00       	call   80102250 <ioapicenable>
}
801002c8:	c9                   	leave  
801002c9:	c3                   	ret    
801002ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801002d0 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
801002d0:	55                   	push   %ebp
801002d1:	89 e5                	mov    %esp,%ebp
801002d3:	57                   	push   %edi
801002d4:	56                   	push   %esi
801002d5:	53                   	push   %ebx
801002d6:	83 ec 3c             	sub    $0x3c,%esp
801002d9:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002dc:	8b 7d 08             	mov    0x8(%ebp),%edi
801002df:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
801002e2:	89 3c 24             	mov    %edi,(%esp)
801002e5:	e8 06 19 00 00       	call   80101bf0 <iunlock>
  target = n;
801002ea:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
801002ed:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801002f4:	e8 97 42 00 00       	call   80104590 <acquire>
  while(n > 0){
801002f9:	85 db                	test   %ebx,%ebx
801002fb:	7f 2c                	jg     80100329 <consoleread+0x59>
801002fd:	e9 c0 00 00 00       	jmp    801003c2 <consoleread+0xf2>
80100302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(input.r == input.w){
      if(proc->killed){
80100308:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010030e:	8b 40 24             	mov    0x24(%eax),%eax
80100311:	85 c0                	test   %eax,%eax
80100313:	75 5b                	jne    80100370 <consoleread+0xa0>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100315:	c7 44 24 04 40 a5 10 	movl   $0x8010a540,0x4(%esp)
8010031c:	80 
8010031d:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100324:	e8 d7 36 00 00       	call   80103a00 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
80100329:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
8010032e:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100334:	74 d2                	je     80100308 <consoleread+0x38>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100336:	89 c2                	mov    %eax,%edx
80100338:	83 e2 7f             	and    $0x7f,%edx
8010033b:	0f b6 8a 40 ff 10 80 	movzbl -0x7fef00c0(%edx),%ecx
80100342:	0f be d1             	movsbl %cl,%edx
80100345:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80100348:	8d 50 01             	lea    0x1(%eax),%edx
    if(c == C('D')){  // EOF
8010034b:	83 7d d4 04          	cmpl   $0x4,-0x2c(%ebp)
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
8010034f:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
    if(c == C('D')){  // EOF
80100355:	74 3a                	je     80100391 <consoleread+0xc1>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100357:	88 0e                	mov    %cl,(%esi)
    --n;
80100359:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010035c:	83 7d d4 0a          	cmpl   $0xa,-0x2c(%ebp)
80100360:	74 39                	je     8010039b <consoleread+0xcb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100362:	85 db                	test   %ebx,%ebx
80100364:	7e 35                	jle    8010039b <consoleread+0xcb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100366:	83 c6 01             	add    $0x1,%esi
80100369:	eb be                	jmp    80100329 <consoleread+0x59>
8010036b:	90                   	nop
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&cons.lock);
80100370:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100377:	e8 c4 41 00 00       	call   80104540 <release>
        ilock(ip);
8010037c:	89 3c 24             	mov    %edi,(%esp)
8010037f:	e8 dc 18 00 00       	call   80101c60 <ilock>
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100384:	83 c4 3c             	add    $0x3c,%esp
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
80100387:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
8010038c:	5b                   	pop    %ebx
8010038d:	5e                   	pop    %esi
8010038e:	5f                   	pop    %edi
8010038f:	5d                   	pop    %ebp
80100390:	c3                   	ret    
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
80100391:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
80100394:	76 05                	jbe    8010039b <consoleread+0xcb>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100396:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
8010039b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010039e:	29 d8                	sub    %ebx,%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
801003a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801003a3:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801003aa:	e8 91 41 00 00       	call   80104540 <release>
  ilock(ip);
801003af:	89 3c 24             	mov    %edi,(%esp)
801003b2:	e8 a9 18 00 00       	call   80101c60 <ilock>
801003b7:	8b 45 e0             	mov    -0x20(%ebp),%eax

  return target - n;
}
801003ba:	83 c4 3c             	add    $0x3c,%esp
801003bd:	5b                   	pop    %ebx
801003be:	5e                   	pop    %esi
801003bf:	5f                   	pop    %edi
801003c0:	5d                   	pop    %ebp
801003c1:	c3                   	ret    
  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
801003c2:	31 c0                	xor    %eax,%eax
801003c4:	eb da                	jmp    801003a0 <consoleread+0xd0>
801003c6:	8d 76 00             	lea    0x0(%esi),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003d0 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
801003d0:	55                   	push   %ebp
801003d1:	89 e5                	mov    %esp,%ebp
801003d3:	56                   	push   %esi
801003d4:	53                   	push   %ebx
801003d5:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801003d8:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
801003d9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
801003df:	8d 75 d0             	lea    -0x30(%ebp),%esi
801003e2:	31 db                	xor    %ebx,%ebx
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
801003e4:	c7 05 74 a5 10 80 00 	movl   $0x0,0x8010a574
801003eb:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
801003ee:	0f b6 00             	movzbl (%eax),%eax
801003f1:	c7 04 24 f5 71 10 80 	movl   $0x801071f5,(%esp)
801003f8:	89 44 24 04          	mov    %eax,0x4(%esp)
801003fc:	e8 6f 04 00 00       	call   80100870 <cprintf>
  cprintf(s);
80100401:	8b 45 08             	mov    0x8(%ebp),%eax
80100404:	89 04 24             	mov    %eax,(%esp)
80100407:	e8 64 04 00 00       	call   80100870 <cprintf>
  cprintf("\n");
8010040c:	c7 04 24 d6 76 10 80 	movl   $0x801076d6,(%esp)
80100413:	e8 58 04 00 00       	call   80100870 <cprintf>
  getcallerpcs(&s, pcs);
80100418:	8d 45 08             	lea    0x8(%ebp),%eax
8010041b:	89 74 24 04          	mov    %esi,0x4(%esp)
8010041f:	89 04 24             	mov    %eax,(%esp)
80100422:	e8 f9 3f 00 00       	call   80104420 <getcallerpcs>
80100427:	90                   	nop
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
80100428:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
8010042b:	83 c3 01             	add    $0x1,%ebx
    cprintf(" %p", pcs[i]);
8010042e:	c7 04 24 11 72 10 80 	movl   $0x80107211,(%esp)
80100435:	89 44 24 04          	mov    %eax,0x4(%esp)
80100439:	e8 32 04 00 00       	call   80100870 <cprintf>
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
8010043e:	83 fb 0a             	cmp    $0xa,%ebx
80100441:	75 e5                	jne    80100428 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
80100443:	c7 05 20 a5 10 80 01 	movl   $0x1,0x8010a520
8010044a:	00 00 00 
8010044d:	eb fe                	jmp    8010044d <panic+0x7d>
8010044f:	90                   	nop

80100450 <consputc>:
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100450:	55                   	push   %ebp
80100451:	89 e5                	mov    %esp,%ebp
80100453:	57                   	push   %edi
80100454:	56                   	push   %esi
80100455:	89 c6                	mov    %eax,%esi
80100457:	53                   	push   %ebx
80100458:	83 ec 1c             	sub    $0x1c,%esp
  if(panicked){
8010045b:	83 3d 20 a5 10 80 00 	cmpl   $0x0,0x8010a520
80100462:	74 03                	je     80100467 <consputc+0x17>
80100464:	fa                   	cli    
80100465:	eb fe                	jmp    80100465 <consputc+0x15>
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
80100467:	3d 00 01 00 00       	cmp    $0x100,%eax
8010046c:	0f 84 ac 00 00 00    	je     8010051e <consputc+0xce>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100472:	89 04 24             	mov    %eax,(%esp)
80100475:	e8 86 58 00 00       	call   80105d00 <uartputc>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010047a:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
8010047f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100484:	89 ca                	mov    %ecx,%edx
80100486:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100487:	bf d5 03 00 00       	mov    $0x3d5,%edi
8010048c:	89 fa                	mov    %edi,%edx
8010048e:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
8010048f:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100492:	89 ca                	mov    %ecx,%edx
80100494:	c1 e3 08             	shl    $0x8,%ebx
80100497:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010049d:	89 fa                	mov    %edi,%edx
8010049f:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
801004a0:	0f b6 c0             	movzbl %al,%eax
801004a3:	09 c3                	or     %eax,%ebx

  if(c == '\n')
801004a5:	83 fe 0a             	cmp    $0xa,%esi
801004a8:	0f 84 fb 00 00 00    	je     801005a9 <consputc+0x159>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
801004ae:	81 fe 00 01 00 00    	cmp    $0x100,%esi
801004b4:	0f 84 e1 00 00 00    	je     8010059b <consputc+0x14b>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004ba:	66 81 e6 ff 00       	and    $0xff,%si
801004bf:	66 81 ce 00 07       	or     $0x700,%si
801004c4:	66 89 b4 1b 00 80 0b 	mov    %si,-0x7ff48000(%ebx,%ebx,1)
801004cb:	80 
801004cc:	83 c3 01             	add    $0x1,%ebx

  if(pos < 0 || pos > 25*80)
801004cf:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801004d5:	0f 87 b4 00 00 00    	ja     8010058f <consputc+0x13f>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
801004db:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004e1:	8d bc 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%edi
801004e8:	7f 5d                	jg     80100547 <consputc+0xf7>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ea:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
801004ef:	b8 0e 00 00 00       	mov    $0xe,%eax
801004f4:	89 ca                	mov    %ecx,%edx
801004f6:	ee                   	out    %al,(%dx)
801004f7:	be d5 03 00 00       	mov    $0x3d5,%esi
801004fc:	89 d8                	mov    %ebx,%eax
801004fe:	c1 f8 08             	sar    $0x8,%eax
80100501:	89 f2                	mov    %esi,%edx
80100503:	ee                   	out    %al,(%dx)
80100504:	b8 0f 00 00 00       	mov    $0xf,%eax
80100509:	89 ca                	mov    %ecx,%edx
8010050b:	ee                   	out    %al,(%dx)
8010050c:	89 d8                	mov    %ebx,%eax
8010050e:	89 f2                	mov    %esi,%edx
80100510:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
80100511:	66 c7 07 20 07       	movw   $0x720,(%edi)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
80100516:	83 c4 1c             	add    $0x1c,%esp
80100519:	5b                   	pop    %ebx
8010051a:	5e                   	pop    %esi
8010051b:	5f                   	pop    %edi
8010051c:	5d                   	pop    %ebp
8010051d:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010051e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100525:	e8 d6 57 00 00       	call   80105d00 <uartputc>
8010052a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100531:	e8 ca 57 00 00       	call   80105d00 <uartputc>
80100536:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010053d:	e8 be 57 00 00       	call   80105d00 <uartputc>
80100542:	e9 33 ff ff ff       	jmp    8010047a <consputc+0x2a>
  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
80100547:	83 eb 50             	sub    $0x50,%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010054a:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
80100551:	00 
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100552:	8d bc 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%edi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100559:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
80100560:	80 
80100561:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100568:	e8 93 41 00 00       	call   80104700 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010056d:	b8 80 07 00 00       	mov    $0x780,%eax
80100572:	29 d8                	sub    %ebx,%eax
80100574:	01 c0                	add    %eax,%eax
80100576:	89 44 24 08          	mov    %eax,0x8(%esp)
8010057a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100581:	00 
80100582:	89 3c 24             	mov    %edi,(%esp)
80100585:	e8 a6 40 00 00       	call   80104630 <memset>
8010058a:	e9 5b ff ff ff       	jmp    801004ea <consputc+0x9a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010058f:	c7 04 24 15 72 10 80 	movl   $0x80107215,(%esp)
80100596:	e8 35 fe ff ff       	call   801003d0 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010059b:	31 c0                	xor    %eax,%eax
8010059d:	85 db                	test   %ebx,%ebx
8010059f:	0f 9f c0             	setg   %al
801005a2:	29 c3                	sub    %eax,%ebx
801005a4:	e9 26 ff ff ff       	jmp    801004cf <consputc+0x7f>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
801005a9:	89 da                	mov    %ebx,%edx
801005ab:	89 d8                	mov    %ebx,%eax
801005ad:	b9 50 00 00 00       	mov    $0x50,%ecx
801005b2:	83 c3 50             	add    $0x50,%ebx
801005b5:	c1 fa 1f             	sar    $0x1f,%edx
801005b8:	f7 f9                	idiv   %ecx
801005ba:	29 d3                	sub    %edx,%ebx
801005bc:	e9 0e ff ff ff       	jmp    801004cf <consputc+0x7f>
801005c1:	eb 0d                	jmp    801005d0 <consolewrite>
801005c3:	90                   	nop
801005c4:	90                   	nop
801005c5:	90                   	nop
801005c6:	90                   	nop
801005c7:	90                   	nop
801005c8:	90                   	nop
801005c9:	90                   	nop
801005ca:	90                   	nop
801005cb:	90                   	nop
801005cc:	90                   	nop
801005cd:	90                   	nop
801005ce:	90                   	nop
801005cf:	90                   	nop

801005d0 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005d0:	55                   	push   %ebp
801005d1:	89 e5                	mov    %esp,%ebp
801005d3:	57                   	push   %edi
801005d4:	56                   	push   %esi
801005d5:	53                   	push   %ebx
801005d6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005d9:	8b 45 08             	mov    0x8(%ebp),%eax
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005dc:	8b 75 10             	mov    0x10(%ebp),%esi
801005df:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  iunlock(ip);
801005e2:	89 04 24             	mov    %eax,(%esp)
801005e5:	e8 06 16 00 00       	call   80101bf0 <iunlock>
  acquire(&cons.lock);
801005ea:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801005f1:	e8 9a 3f 00 00       	call   80104590 <acquire>
  for(i = 0; i < n; i++)
801005f6:	85 f6                	test   %esi,%esi
801005f8:	7e 16                	jle    80100610 <consolewrite+0x40>
801005fa:	31 db                	xor    %ebx,%ebx
801005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i] & 0xff);
80100600:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100604:	83 c3 01             	add    $0x1,%ebx
    consputc(buf[i] & 0xff);
80100607:	e8 44 fe ff ff       	call   80100450 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010060c:	39 de                	cmp    %ebx,%esi
8010060e:	7f f0                	jg     80100600 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100610:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100617:	e8 24 3f 00 00       	call   80104540 <release>
  ilock(ip);
8010061c:	8b 45 08             	mov    0x8(%ebp),%eax
8010061f:	89 04 24             	mov    %eax,(%esp)
80100622:	e8 39 16 00 00       	call   80101c60 <ilock>

  return n;
}
80100627:	83 c4 1c             	add    $0x1c,%esp
8010062a:	89 f0                	mov    %esi,%eax
8010062c:	5b                   	pop    %ebx
8010062d:	5e                   	pop    %esi
8010062e:	5f                   	pop    %edi
8010062f:	5d                   	pop    %ebp
80100630:	c3                   	ret    
80100631:	eb 0d                	jmp    80100640 <consoleintr>
80100633:	90                   	nop
80100634:	90                   	nop
80100635:	90                   	nop
80100636:	90                   	nop
80100637:	90                   	nop
80100638:	90                   	nop
80100639:	90                   	nop
8010063a:	90                   	nop
8010063b:	90                   	nop
8010063c:	90                   	nop
8010063d:	90                   	nop
8010063e:	90                   	nop
8010063f:	90                   	nop

80100640 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
  int c, doprocdump = 0;

  acquire(&cons.lock);
80100644:	31 ff                	xor    %edi,%edi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100646:	56                   	push   %esi
80100647:	53                   	push   %ebx
80100648:	83 ec 1c             	sub    $0x1c,%esp
8010064b:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, doprocdump = 0;

  acquire(&cons.lock);
8010064e:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100655:	e8 36 3f 00 00       	call   80104590 <acquire>
8010065a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
80100660:	ff d6                	call   *%esi
80100662:	85 c0                	test   %eax,%eax
80100664:	89 c3                	mov    %eax,%ebx
80100666:	0f 88 98 00 00 00    	js     80100704 <consoleintr+0xc4>
    switch(c){
8010066c:	83 fb 10             	cmp    $0x10,%ebx
8010066f:	90                   	nop
80100670:	0f 84 32 01 00 00    	je     801007a8 <consoleintr+0x168>
80100676:	0f 8f a4 00 00 00    	jg     80100720 <consoleintr+0xe0>
8010067c:	83 fb 08             	cmp    $0x8,%ebx
8010067f:	90                   	nop
80100680:	0f 84 a8 00 00 00    	je     8010072e <consoleintr+0xee>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100686:	85 db                	test   %ebx,%ebx
80100688:	74 d6                	je     80100660 <consoleintr+0x20>
8010068a:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010068f:	89 c2                	mov    %eax,%edx
80100691:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
80100697:	83 fa 7f             	cmp    $0x7f,%edx
8010069a:	77 c4                	ja     80100660 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
8010069c:	83 fb 0d             	cmp    $0xd,%ebx
8010069f:	0f 84 0d 01 00 00    	je     801007b2 <consoleintr+0x172>
        input.buf[input.e++ % INPUT_BUF] = c;
801006a5:	89 c2                	mov    %eax,%edx
801006a7:	83 c0 01             	add    $0x1,%eax
801006aa:	83 e2 7f             	and    $0x7f,%edx
801006ad:	88 9a 40 ff 10 80    	mov    %bl,-0x7fef00c0(%edx)
801006b3:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(c);
801006b8:	89 d8                	mov    %ebx,%eax
801006ba:	e8 91 fd ff ff       	call   80100450 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801006bf:	83 fb 04             	cmp    $0x4,%ebx
801006c2:	0f 84 08 01 00 00    	je     801007d0 <consoleintr+0x190>
801006c8:	83 fb 0a             	cmp    $0xa,%ebx
801006cb:	0f 84 ff 00 00 00    	je     801007d0 <consoleintr+0x190>
801006d1:	8b 15 c0 ff 10 80    	mov    0x8010ffc0,%edx
801006d7:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801006dc:	83 ea 80             	sub    $0xffffff80,%edx
801006df:	39 d0                	cmp    %edx,%eax
801006e1:	0f 85 79 ff ff ff    	jne    80100660 <consoleintr+0x20>
          input.w = input.e;
801006e7:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
801006ec:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
801006f3:	e8 a8 31 00 00       	call   801038a0 <wakeup>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
801006f8:	ff d6                	call   *%esi
801006fa:	85 c0                	test   %eax,%eax
801006fc:	89 c3                	mov    %eax,%ebx
801006fe:	0f 89 68 ff ff ff    	jns    8010066c <consoleintr+0x2c>
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100704:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
8010070b:	e8 30 3e 00 00       	call   80104540 <release>
  if(doprocdump) {
80100710:	85 ff                	test   %edi,%edi
80100712:	0f 85 c2 00 00 00    	jne    801007da <consoleintr+0x19a>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100718:	83 c4 1c             	add    $0x1c,%esp
8010071b:	5b                   	pop    %ebx
8010071c:	5e                   	pop    %esi
8010071d:	5f                   	pop    %edi
8010071e:	5d                   	pop    %ebp
8010071f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100720:	83 fb 15             	cmp    $0x15,%ebx
80100723:	74 33                	je     80100758 <consoleintr+0x118>
80100725:	83 fb 7f             	cmp    $0x7f,%ebx
80100728:	0f 85 58 ff ff ff    	jne    80100686 <consoleintr+0x46>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010072e:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100733:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100739:	0f 84 21 ff ff ff    	je     80100660 <consoleintr+0x20>
        input.e--;
8010073f:	83 e8 01             	sub    $0x1,%eax
80100742:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100747:	b8 00 01 00 00       	mov    $0x100,%eax
8010074c:	e8 ff fc ff ff       	call   80100450 <consputc>
80100751:	e9 0a ff ff ff       	jmp    80100660 <consoleintr+0x20>
80100756:	66 90                	xchg   %ax,%ax
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100758:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010075d:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100763:	75 2b                	jne    80100790 <consoleintr+0x150>
80100765:	e9 f6 fe ff ff       	jmp    80100660 <consoleintr+0x20>
8010076a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100770:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100775:	b8 00 01 00 00       	mov    $0x100,%eax
8010077a:	e8 d1 fc ff ff       	call   80100450 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010077f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100784:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010078a:	0f 84 d0 fe ff ff    	je     80100660 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100790:	83 e8 01             	sub    $0x1,%eax
80100793:	89 c2                	mov    %eax,%edx
80100795:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100798:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
8010079f:	75 cf                	jne    80100770 <consoleintr+0x130>
801007a1:	e9 ba fe ff ff       	jmp    80100660 <consoleintr+0x20>
801007a6:	66 90                	xchg   %ax,%ax
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
801007a8:	bf 01 00 00 00       	mov    $0x1,%edi
801007ad:	e9 ae fe ff ff       	jmp    80100660 <consoleintr+0x20>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801007b2:	89 c2                	mov    %eax,%edx
801007b4:	83 c0 01             	add    $0x1,%eax
801007b7:	83 e2 7f             	and    $0x7f,%edx
801007ba:	c6 82 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%edx)
801007c1:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(c);
801007c6:	b8 0a 00 00 00       	mov    $0xa,%eax
801007cb:	e8 80 fc ff ff       	call   80100450 <consputc>
801007d0:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801007d5:	e9 0d ff ff ff       	jmp    801006e7 <consoleintr+0xa7>
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801007da:	83 c4 1c             	add    $0x1c,%esp
801007dd:	5b                   	pop    %ebx
801007de:	5e                   	pop    %esi
801007df:	5f                   	pop    %edi
801007e0:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
801007e1:	e9 5a 2f 00 00       	jmp    80103740 <procdump>
801007e6:	8d 76 00             	lea    0x0(%esi),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	89 d6                	mov    %edx,%esi
801007f7:	53                   	push   %ebx
801007f8:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801007fb:	85 c9                	test   %ecx,%ecx
801007fd:	74 04                	je     80100803 <printint+0x13>
801007ff:	85 c0                	test   %eax,%eax
80100801:	78 55                	js     80100858 <printint+0x68>
    x = -xx;
  else
    x = xx;
80100803:	31 ff                	xor    %edi,%edi
80100805:	31 c9                	xor    %ecx,%ecx
80100807:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  i = 0;
  do{
    buf[i++] = digits[x % base];
80100810:	31 d2                	xor    %edx,%edx
80100812:	f7 f6                	div    %esi
80100814:	0f b6 92 38 72 10 80 	movzbl -0x7fef8dc8(%edx),%edx
8010081b:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
8010081e:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
80100821:	85 c0                	test   %eax,%eax
80100823:	75 eb                	jne    80100810 <printint+0x20>

  if(sign)
80100825:	85 ff                	test   %edi,%edi
80100827:	74 08                	je     80100831 <printint+0x41>
    buf[i++] = '-';
80100829:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
8010082e:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
80100831:	8d 71 ff             	lea    -0x1(%ecx),%esi
80100834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
80100838:	0f be 04 33          	movsbl (%ebx,%esi,1),%eax
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010083c:	83 ee 01             	sub    $0x1,%esi
    consputc(buf[i]);
8010083f:	e8 0c fc ff ff       	call   80100450 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100844:	83 fe ff             	cmp    $0xffffffff,%esi
80100847:	75 ef                	jne    80100838 <printint+0x48>
    consputc(buf[i]);
}
80100849:	83 c4 1c             	add    $0x1c,%esp
8010084c:	5b                   	pop    %ebx
8010084d:	5e                   	pop    %esi
8010084e:	5f                   	pop    %edi
8010084f:	5d                   	pop    %ebp
80100850:	c3                   	ret    
80100851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
80100858:	f7 d8                	neg    %eax
8010085a:	bf 01 00 00 00       	mov    $0x1,%edi
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010085f:	eb a4                	jmp    80100805 <printint+0x15>
80100861:	eb 0d                	jmp    80100870 <cprintf>
80100863:	90                   	nop
80100864:	90                   	nop
80100865:	90                   	nop
80100866:	90                   	nop
80100867:	90                   	nop
80100868:	90                   	nop
80100869:	90                   	nop
8010086a:	90                   	nop
8010086b:	90                   	nop
8010086c:	90                   	nop
8010086d:	90                   	nop
8010086e:	90                   	nop
8010086f:	90                   	nop

80100870 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100870:	55                   	push   %ebp
80100871:	89 e5                	mov    %esp,%ebp
80100873:	57                   	push   %edi
80100874:	56                   	push   %esi
80100875:	53                   	push   %ebx
80100876:	83 ec 2c             	sub    $0x2c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100879:	8b 3d 74 a5 10 80    	mov    0x8010a574,%edi
  if(locking)
8010087f:	85 ff                	test   %edi,%edi
80100881:	0f 85 31 01 00 00    	jne    801009b8 <cprintf+0x148>
    acquire(&cons.lock);

  if (fmt == 0)
80100887:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010088a:	85 c9                	test   %ecx,%ecx
8010088c:	0f 84 37 01 00 00    	je     801009c9 <cprintf+0x159>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100892:	0f b6 01             	movzbl (%ecx),%eax
80100895:	85 c0                	test   %eax,%eax
80100897:	0f 84 8b 00 00 00    	je     80100928 <cprintf+0xb8>
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
8010089d:	8d 75 0c             	lea    0xc(%ebp),%esi
801008a0:	31 db                	xor    %ebx,%ebx
801008a2:	eb 3f                	jmp    801008e3 <cprintf+0x73>
801008a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
801008a8:	83 fa 25             	cmp    $0x25,%edx
801008ab:	0f 84 af 00 00 00    	je     80100960 <cprintf+0xf0>
801008b1:	83 fa 64             	cmp    $0x64,%edx
801008b4:	0f 84 86 00 00 00    	je     80100940 <cprintf+0xd0>
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801008ba:	b8 25 00 00 00       	mov    $0x25,%eax
801008bf:	89 55 e0             	mov    %edx,-0x20(%ebp)
801008c2:	e8 89 fb ff ff       	call   80100450 <consputc>
      consputc(c);
801008c7:	8b 55 e0             	mov    -0x20(%ebp),%edx
801008ca:	89 d0                	mov    %edx,%eax
801008cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801008d0:	e8 7b fb ff ff       	call   80100450 <consputc>
801008d5:	8b 4d 08             	mov    0x8(%ebp),%ecx

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008d8:	83 c3 01             	add    $0x1,%ebx
801008db:	0f b6 04 19          	movzbl (%ecx,%ebx,1),%eax
801008df:	85 c0                	test   %eax,%eax
801008e1:	74 45                	je     80100928 <cprintf+0xb8>
    if(c != '%'){
801008e3:	83 f8 25             	cmp    $0x25,%eax
801008e6:	75 e8                	jne    801008d0 <cprintf+0x60>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801008e8:	83 c3 01             	add    $0x1,%ebx
801008eb:	0f b6 14 19          	movzbl (%ecx,%ebx,1),%edx
    if(c == 0)
801008ef:	85 d2                	test   %edx,%edx
801008f1:	74 35                	je     80100928 <cprintf+0xb8>
      break;
    switch(c){
801008f3:	83 fa 70             	cmp    $0x70,%edx
801008f6:	74 0f                	je     80100907 <cprintf+0x97>
801008f8:	7e ae                	jle    801008a8 <cprintf+0x38>
801008fa:	83 fa 73             	cmp    $0x73,%edx
801008fd:	8d 76 00             	lea    0x0(%esi),%esi
80100900:	74 76                	je     80100978 <cprintf+0x108>
80100902:	83 fa 78             	cmp    $0x78,%edx
80100905:	75 b3                	jne    801008ba <cprintf+0x4a>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100907:	8b 06                	mov    (%esi),%eax
80100909:	31 c9                	xor    %ecx,%ecx
8010090b:	ba 10 00 00 00       	mov    $0x10,%edx

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100910:	83 c3 01             	add    $0x1,%ebx
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100913:	83 c6 04             	add    $0x4,%esi
80100916:	e8 d5 fe ff ff       	call   801007f0 <printint>
8010091b:	8b 4d 08             	mov    0x8(%ebp),%ecx

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010091e:	0f b6 04 19          	movzbl (%ecx,%ebx,1),%eax
80100922:	85 c0                	test   %eax,%eax
80100924:	75 bd                	jne    801008e3 <cprintf+0x73>
80100926:	66 90                	xchg   %ax,%ax
      consputc(c);
      break;
    }
  }

  if(locking)
80100928:	85 ff                	test   %edi,%edi
8010092a:	74 0c                	je     80100938 <cprintf+0xc8>
    release(&cons.lock);
8010092c:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
80100933:	e8 08 3c 00 00       	call   80104540 <release>
}
80100938:	83 c4 2c             	add    $0x2c,%esp
8010093b:	5b                   	pop    %ebx
8010093c:	5e                   	pop    %esi
8010093d:	5f                   	pop    %edi
8010093e:	5d                   	pop    %ebp
8010093f:	c3                   	ret    
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
80100940:	8b 06                	mov    (%esi),%eax
80100942:	b9 01 00 00 00       	mov    $0x1,%ecx
80100947:	ba 0a 00 00 00       	mov    $0xa,%edx
8010094c:	83 c6 04             	add    $0x4,%esi
8010094f:	e8 9c fe ff ff       	call   801007f0 <printint>
80100954:	8b 4d 08             	mov    0x8(%ebp),%ecx
      break;
80100957:	e9 7c ff ff ff       	jmp    801008d8 <cprintf+0x68>
8010095c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100960:	b8 25 00 00 00       	mov    $0x25,%eax
80100965:	e8 e6 fa ff ff       	call   80100450 <consputc>
8010096a:	8b 4d 08             	mov    0x8(%ebp),%ecx
      break;
8010096d:	e9 66 ff ff ff       	jmp    801008d8 <cprintf+0x68>
80100972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100978:	8b 16                	mov    (%esi),%edx
8010097a:	b8 31 72 10 80       	mov    $0x80107231,%eax
8010097f:	83 c6 04             	add    $0x4,%esi
80100982:	85 d2                	test   %edx,%edx
80100984:	0f 44 d0             	cmove  %eax,%edx
        s = "(null)";
      for(; *s; s++)
80100987:	0f b6 02             	movzbl (%edx),%eax
8010098a:	84 c0                	test   %al,%al
8010098c:	0f 84 46 ff ff ff    	je     801008d8 <cprintf+0x68>
80100992:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100995:	89 d3                	mov    %edx,%ebx
80100997:	90                   	nop
        consputc(*s);
80100998:	0f be c0             	movsbl %al,%eax
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
8010099b:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
8010099e:	e8 ad fa ff ff       	call   80100450 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801009a3:	0f b6 03             	movzbl (%ebx),%eax
801009a6:	84 c0                	test   %al,%al
801009a8:	75 ee                	jne    80100998 <cprintf+0x128>
801009aa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801009ad:	8b 4d 08             	mov    0x8(%ebp),%ecx
801009b0:	e9 23 ff ff ff       	jmp    801008d8 <cprintf+0x68>
801009b5:	8d 76 00             	lea    0x0(%esi),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801009b8:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801009bf:	e8 cc 3b 00 00       	call   80104590 <acquire>
801009c4:	e9 be fe ff ff       	jmp    80100887 <cprintf+0x17>

  if (fmt == 0)
    panic("null fmt");
801009c9:	c7 04 24 28 72 10 80 	movl   $0x80107228,(%esp)
801009d0:	e8 fb f9 ff ff       	call   801003d0 <panic>
	...

801009e0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009e0:	55                   	push   %ebp
801009e1:	89 e5                	mov    %esp,%ebp
801009e3:	57                   	push   %edi
801009e4:	56                   	push   %esi
801009e5:	53                   	push   %ebx
801009e6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
801009ec:	e8 bf 23 00 00       	call   80102db0 <begin_op>

  if((ip = namei(path)) == 0){
801009f1:	8b 45 08             	mov    0x8(%ebp),%eax
801009f4:	89 04 24             	mov    %eax,(%esp)
801009f7:	e8 c4 14 00 00       	call   80101ec0 <namei>
801009fc:	85 c0                	test   %eax,%eax
801009fe:	89 c7                	mov    %eax,%edi
80100a00:	0f 84 32 02 00 00    	je     80100c38 <exec+0x258>
    end_op();
    return -1;
  }
  ilock(ip);
80100a06:	89 04 24             	mov    %eax,(%esp)
80100a09:	e8 52 12 00 00       	call   80101c60 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a0e:	8d 45 94             	lea    -0x6c(%ebp),%eax
80100a11:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100a18:	00 
80100a19:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100a20:	00 
80100a21:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a25:	89 3c 24             	mov    %edi,(%esp)
80100a28:	e8 43 0e 00 00       	call   80101870 <readi>
80100a2d:	83 f8 34             	cmp    $0x34,%eax
80100a30:	0f 85 fa 01 00 00    	jne    80100c30 <exec+0x250>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a36:	81 7d 94 7f 45 4c 46 	cmpl   $0x464c457f,-0x6c(%ebp)
80100a3d:	0f 85 ed 01 00 00    	jne    80100c30 <exec+0x250>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a43:	e8 28 60 00 00       	call   80106a70 <setupkvm>
80100a48:	85 c0                	test   %eax,%eax
80100a4a:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a50:	0f 84 da 01 00 00    	je     80100c30 <exec+0x250>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a56:	66 83 7d c0 00       	cmpw   $0x0,-0x40(%ebp)
80100a5b:	8b 5d b0             	mov    -0x50(%ebp),%ebx
80100a5e:	0f 84 d1 02 00 00    	je     80100d35 <exec+0x355>
80100a64:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100a6b:	00 00 00 
80100a6e:	31 f6                	xor    %esi,%esi
80100a70:	eb 18                	jmp    80100a8a <exec+0xaa>
80100a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100a78:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80100a7c:	83 c6 01             	add    $0x1,%esi
80100a7f:	39 f0                	cmp    %esi,%eax
80100a81:	0f 8e c1 00 00 00    	jle    80100b48 <exec+0x168>
80100a87:	83 c3 20             	add    $0x20,%ebx
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a8a:	8d 55 c8             	lea    -0x38(%ebp),%edx
80100a8d:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100a94:	00 
80100a95:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100a99:	89 54 24 04          	mov    %edx,0x4(%esp)
80100a9d:	89 3c 24             	mov    %edi,(%esp)
80100aa0:	e8 cb 0d 00 00       	call   80101870 <readi>
80100aa5:	83 f8 20             	cmp    $0x20,%eax
80100aa8:	75 76                	jne    80100b20 <exec+0x140>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100aaa:	83 7d c8 01          	cmpl   $0x1,-0x38(%ebp)
80100aae:	75 c8                	jne    80100a78 <exec+0x98>
      continue;
    if(ph.memsz < ph.filesz)
80100ab0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100ab3:	3b 45 d8             	cmp    -0x28(%ebp),%eax
80100ab6:	72 68                	jb     80100b20 <exec+0x140>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ab8:	03 45 d0             	add    -0x30(%ebp),%eax
80100abb:	72 63                	jb     80100b20 <exec+0x140>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100abd:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ac1:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100ac7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100acd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100ad1:	89 04 24             	mov    %eax,(%esp)
80100ad4:	e8 e7 62 00 00       	call   80106dc0 <allocuvm>
80100ad9:	85 c0                	test   %eax,%eax
80100adb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ae1:	74 3d                	je     80100b20 <exec+0x140>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100ae3:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100ae6:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100aeb:	75 33                	jne    80100b20 <exec+0x140>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100aed:	8b 55 d8             	mov    -0x28(%ebp),%edx
80100af0:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100af4:	89 44 24 04          	mov    %eax,0x4(%esp)
80100af8:	89 54 24 10          	mov    %edx,0x10(%esp)
80100afc:	8b 55 cc             	mov    -0x34(%ebp),%edx
80100aff:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b03:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100b09:	89 14 24             	mov    %edx,(%esp)
80100b0c:	e8 cf 63 00 00       	call   80106ee0 <loaduvm>
80100b11:	85 c0                	test   %eax,%eax
80100b13:	0f 89 5f ff ff ff    	jns    80100a78 <exec+0x98>
80100b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b20:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100b26:	89 04 24             	mov    %eax,(%esp)
80100b29:	e8 42 61 00 00       	call   80106c70 <freevm>
  if(ip){
80100b2e:	85 ff                	test   %edi,%edi
80100b30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b35:	0f 85 f5 00 00 00    	jne    80100c30 <exec+0x250>
    iunlockput(ip);
    end_op();
  }
  return -1;
}
80100b3b:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100b41:	5b                   	pop    %ebx
80100b42:	5e                   	pop    %esi
80100b43:	5f                   	pop    %edi
80100b44:	5d                   	pop    %ebp
80100b45:	c3                   	ret    
80100b46:	66 90                	xchg   %ax,%ax
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b48:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100b4e:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
80100b54:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80100b5a:	8d b3 00 20 00 00    	lea    0x2000(%ebx),%esi
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b60:	89 3c 24             	mov    %edi,(%esp)
80100b63:	e8 d8 10 00 00       	call   80101c40 <iunlockput>
  end_op();
80100b68:	e8 13 21 00 00       	call   80102c80 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b6d:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100b73:	89 74 24 08          	mov    %esi,0x8(%esp)
80100b77:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100b7b:	89 0c 24             	mov    %ecx,(%esp)
80100b7e:	e8 3d 62 00 00       	call   80106dc0 <allocuvm>
80100b83:	85 c0                	test   %eax,%eax
80100b85:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b8b:	0f 84 96 00 00 00    	je     80100c27 <exec+0x247>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100b91:	2d 00 20 00 00       	sub    $0x2000,%eax
80100b96:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b9a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100ba0:	89 04 24             	mov    %eax,(%esp)
80100ba3:	e8 68 5f 00 00       	call   80106b10 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100ba8:	8b 55 0c             	mov    0xc(%ebp),%edx
80100bab:	8b 02                	mov    (%edx),%eax
80100bad:	85 c0                	test   %eax,%eax
80100baf:	0f 84 8c 01 00 00    	je     80100d41 <exec+0x361>
80100bb5:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100bb8:	31 f6                	xor    %esi,%esi
80100bba:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100bc0:	eb 28                	jmp    80100bea <exec+0x20a>
80100bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100bc8:	89 9c b5 10 ff ff ff 	mov    %ebx,-0xf0(%ebp,%esi,4)
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100bcf:	8b 45 0c             	mov    0xc(%ebp),%eax
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bd2:	83 c6 01             	add    $0x1,%esi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100bd5:	8d 95 04 ff ff ff    	lea    -0xfc(%ebp),%edx
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100bdb:	8d 3c b0             	lea    (%eax,%esi,4),%edi
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bde:	8b 04 b0             	mov    (%eax,%esi,4),%eax
80100be1:	85 c0                	test   %eax,%eax
80100be3:	74 62                	je     80100c47 <exec+0x267>
    if(argc >= MAXARG)
80100be5:	83 fe 20             	cmp    $0x20,%esi
80100be8:	74 3d                	je     80100c27 <exec+0x247>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bea:	89 04 24             	mov    %eax,(%esp)
80100bed:	e8 6e 3c 00 00       	call   80104860 <strlen>
80100bf2:	f7 d0                	not    %eax
80100bf4:	8d 1c 18             	lea    (%eax,%ebx,1),%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100bf7:	8b 07                	mov    (%edi),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bf9:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100bfc:	89 04 24             	mov    %eax,(%esp)
80100bff:	e8 5c 3c 00 00       	call   80104860 <strlen>
80100c04:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100c0a:	83 c0 01             	add    $0x1,%eax
80100c0d:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c11:	8b 07                	mov    (%edi),%eax
80100c13:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c17:	89 0c 24             	mov    %ecx,(%esp)
80100c1a:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c1e:	e8 2d 5d 00 00       	call   80106950 <copyout>
80100c23:	85 c0                	test   %eax,%eax
80100c25:	79 a1                	jns    80100bc8 <exec+0x1e8>
 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
    end_op();
80100c27:	31 ff                	xor    %edi,%edi
80100c29:	e9 f2 fe ff ff       	jmp    80100b20 <exec+0x140>
80100c2e:	66 90                	xchg   %ax,%ax

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100c30:	89 3c 24             	mov    %edi,(%esp)
80100c33:	e8 08 10 00 00       	call   80101c40 <iunlockput>
    end_op();
80100c38:	e8 43 20 00 00       	call   80102c80 <end_op>
80100c3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c42:	e9 f4 fe ff ff       	jmp    80100b3b <exec+0x15b>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c47:	8d 4e 03             	lea    0x3(%esi),%ecx
80100c4a:	8d 3c b5 04 00 00 00 	lea    0x4(,%esi,4),%edi
80100c51:	8d 04 b5 10 00 00 00 	lea    0x10(,%esi,4),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c58:	c7 84 8d 04 ff ff ff 	movl   $0x0,-0xfc(%ebp,%ecx,4)
80100c5f:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c63:	89 d9                	mov    %ebx,%ecx

  sp -= (3+argc+1) * 4;
80100c65:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c67:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c6b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c71:	29 f9                	sub    %edi,%ecx
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
80100c73:	c7 85 04 ff ff ff ff 	movl   $0xffffffff,-0xfc(%ebp)
80100c7a:	ff ff ff 
  ustack[1] = argc;
80100c7d:	89 b5 08 ff ff ff    	mov    %esi,-0xf8(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c83:	89 8d 0c ff ff ff    	mov    %ecx,-0xf4(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c89:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c8d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c91:	89 04 24             	mov    %eax,(%esp)
80100c94:	e8 b7 5c 00 00       	call   80106950 <copyout>
80100c99:	85 c0                	test   %eax,%eax
80100c9b:	78 8a                	js     80100c27 <exec+0x247>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100c9d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100ca0:	0f b6 11             	movzbl (%ecx),%edx
80100ca3:	84 d2                	test   %dl,%dl
80100ca5:	74 19                	je     80100cc0 <exec+0x2e0>
80100ca7:	89 c8                	mov    %ecx,%eax
80100ca9:	83 c0 01             	add    $0x1,%eax
80100cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == '/')
80100cb0:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cb3:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
80100cb6:	0f 44 c8             	cmove  %eax,%ecx
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cb9:	83 c0 01             	add    $0x1,%eax
80100cbc:	84 d2                	test   %dl,%dl
80100cbe:	75 f0                	jne    80100cb0 <exec+0x2d0>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100cc0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cc6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100cca:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100cd1:	00 
80100cd2:	83 c0 6c             	add    $0x6c,%eax
80100cd5:	89 04 24             	mov    %eax,(%esp)
80100cd8:	e8 43 3b 00 00       	call   80104820 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100cdd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100ce3:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100ce9:	8b 70 04             	mov    0x4(%eax),%esi
  proc->pgdir = pgdir;
80100cec:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100cef:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cf5:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100cfb:	89 08                	mov    %ecx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100cfd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d03:	8b 55 ac             	mov    -0x54(%ebp),%edx
80100d06:	8b 40 18             	mov    0x18(%eax),%eax
80100d09:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100d0c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d12:	8b 40 18             	mov    0x18(%eax),%eax
80100d15:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(proc);
80100d18:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d1e:	89 04 24             	mov    %eax,(%esp)
80100d21:	e8 7a 62 00 00       	call   80106fa0 <switchuvm>
  freevm(oldpgdir);
80100d26:	89 34 24             	mov    %esi,(%esp)
80100d29:	e8 42 5f 00 00       	call   80106c70 <freevm>
80100d2e:	31 c0                	xor    %eax,%eax
  return 0;
80100d30:	e9 06 fe ff ff       	jmp    80100b3b <exec+0x15b>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d35:	be 00 20 00 00       	mov    $0x2000,%esi
80100d3a:	31 db                	xor    %ebx,%ebx
80100d3c:	e9 1f fe ff ff       	jmp    80100b60 <exec+0x180>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d41:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100d47:	b0 10                	mov    $0x10,%al
80100d49:	bf 04 00 00 00       	mov    $0x4,%edi
80100d4e:	b9 03 00 00 00       	mov    $0x3,%ecx
80100d53:	31 f6                	xor    %esi,%esi
80100d55:	8d 95 04 ff ff ff    	lea    -0xfc(%ebp),%edx
80100d5b:	e9 f8 fe ff ff       	jmp    80100c58 <exec+0x278>

80100d60 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	57                   	push   %edi
80100d64:	56                   	push   %esi
80100d65:	53                   	push   %ebx
80100d66:	83 ec 2c             	sub    $0x2c,%esp
80100d69:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100d6f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d72:	8b 45 10             	mov    0x10(%ebp),%eax
80100d75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100d78:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80100d7c:	0f 84 ae 00 00 00    	je     80100e30 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80100d82:	8b 03                	mov    (%ebx),%eax
80100d84:	83 f8 01             	cmp    $0x1,%eax
80100d87:	0f 84 c2 00 00 00    	je     80100e4f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100d8d:	83 f8 02             	cmp    $0x2,%eax
80100d90:	0f 85 d7 00 00 00    	jne    80100e6d <filewrite+0x10d>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100d96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d99:	31 f6                	xor    %esi,%esi
80100d9b:	85 c0                	test   %eax,%eax
80100d9d:	7f 31                	jg     80100dd0 <filewrite+0x70>
80100d9f:	e9 9c 00 00 00       	jmp    80100e40 <filewrite+0xe0>
80100da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80100da8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
80100dab:	8b 53 10             	mov    0x10(%ebx),%edx
80100dae:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100db1:	89 14 24             	mov    %edx,(%esp)
80100db4:	e8 37 0e 00 00       	call   80101bf0 <iunlock>
      end_op();
80100db9:	e8 c2 1e 00 00       	call   80102c80 <end_op>
80100dbe:	8b 45 dc             	mov    -0x24(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80100dc1:	39 f8                	cmp    %edi,%eax
80100dc3:	0f 85 98 00 00 00    	jne    80100e61 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80100dc9:	01 c6                	add    %eax,%esi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100dcb:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80100dce:	7e 70                	jle    80100e40 <filewrite+0xe0>
      int n1 = n - i;
80100dd0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80100dd3:	b8 00 1a 00 00       	mov    $0x1a00,%eax
80100dd8:	29 f7                	sub    %esi,%edi
80100dda:	81 ff 00 1a 00 00    	cmp    $0x1a00,%edi
80100de0:	0f 4f f8             	cmovg  %eax,%edi
      if(n1 > max)
        n1 = max;

      begin_op();
80100de3:	e8 c8 1f 00 00       	call   80102db0 <begin_op>
      ilock(f->ip);
80100de8:	8b 43 10             	mov    0x10(%ebx),%eax
80100deb:	89 04 24             	mov    %eax,(%esp)
80100dee:	e8 6d 0e 00 00       	call   80101c60 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80100df3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100df7:	8b 43 14             	mov    0x14(%ebx),%eax
80100dfa:	89 44 24 08          	mov    %eax,0x8(%esp)
80100dfe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100e01:	01 f0                	add    %esi,%eax
80100e03:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e07:	8b 43 10             	mov    0x10(%ebx),%eax
80100e0a:	89 04 24             	mov    %eax,(%esp)
80100e0d:	e8 3e 09 00 00       	call   80101750 <writei>
80100e12:	85 c0                	test   %eax,%eax
80100e14:	7f 92                	jg     80100da8 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
80100e16:	8b 53 10             	mov    0x10(%ebx),%edx
80100e19:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100e1c:	89 14 24             	mov    %edx,(%esp)
80100e1f:	e8 cc 0d 00 00       	call   80101bf0 <iunlock>
      end_op();
80100e24:	e8 57 1e 00 00       	call   80102c80 <end_op>

      if(r < 0)
80100e29:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e2c:	85 c0                	test   %eax,%eax
80100e2e:	74 91                	je     80100dc1 <filewrite+0x61>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100e30:	83 c4 2c             	add    $0x2c,%esp
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
80100e33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100e38:	5b                   	pop    %ebx
80100e39:	5e                   	pop    %esi
80100e3a:	5f                   	pop    %edi
80100e3b:	5d                   	pop    %ebp
80100e3c:	c3                   	ret    
80100e3d:	8d 76 00             	lea    0x0(%esi),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80100e40:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
  }
  panic("filewrite");
80100e43:	89 f0                	mov    %esi,%eax
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80100e45:	75 e9                	jne    80100e30 <filewrite+0xd0>
  }
  panic("filewrite");
}
80100e47:	83 c4 2c             	add    $0x2c,%esp
80100e4a:	5b                   	pop    %ebx
80100e4b:	5e                   	pop    %esi
80100e4c:	5f                   	pop    %edi
80100e4d:	5d                   	pop    %ebp
80100e4e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80100e4f:	8b 43 0c             	mov    0xc(%ebx),%eax
80100e52:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100e55:	83 c4 2c             	add    $0x2c,%esp
80100e58:	5b                   	pop    %ebx
80100e59:	5e                   	pop    %esi
80100e5a:	5f                   	pop    %edi
80100e5b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80100e5c:	e9 2f 26 00 00       	jmp    80103490 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80100e61:	c7 04 24 49 72 10 80 	movl   $0x80107249,(%esp)
80100e68:	e8 63 f5 ff ff       	call   801003d0 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
80100e6d:	c7 04 24 4f 72 10 80 	movl   $0x8010724f,(%esp)
80100e74:	e8 57 f5 ff ff       	call   801003d0 <panic>
80100e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e80 <fileread>:
}

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100e80:	55                   	push   %ebp
80100e81:	89 e5                	mov    %esp,%ebp
80100e83:	83 ec 38             	sub    $0x38,%esp
80100e86:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100e89:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100e8c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100e8f:	8b 75 0c             	mov    0xc(%ebp),%esi
80100e92:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100e95:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100e98:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100e9c:	74 5a                	je     80100ef8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100e9e:	8b 03                	mov    (%ebx),%eax
80100ea0:	83 f8 01             	cmp    $0x1,%eax
80100ea3:	74 6b                	je     80100f10 <fileread+0x90>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100ea5:	83 f8 02             	cmp    $0x2,%eax
80100ea8:	75 7d                	jne    80100f27 <fileread+0xa7>
    ilock(f->ip);
80100eaa:	8b 43 10             	mov    0x10(%ebx),%eax
80100ead:	89 04 24             	mov    %eax,(%esp)
80100eb0:	e8 ab 0d 00 00       	call   80101c60 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100eb5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100eb9:	8b 43 14             	mov    0x14(%ebx),%eax
80100ebc:	89 74 24 04          	mov    %esi,0x4(%esp)
80100ec0:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ec4:	8b 43 10             	mov    0x10(%ebx),%eax
80100ec7:	89 04 24             	mov    %eax,(%esp)
80100eca:	e8 a1 09 00 00       	call   80101870 <readi>
80100ecf:	85 c0                	test   %eax,%eax
80100ed1:	7e 03                	jle    80100ed6 <fileread+0x56>
      f->off += r;
80100ed3:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100ed6:	8b 53 10             	mov    0x10(%ebx),%edx
80100ed9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100edc:	89 14 24             	mov    %edx,(%esp)
80100edf:	e8 0c 0d 00 00       	call   80101bf0 <iunlock>
    return r;
80100ee4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
80100ee7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100eea:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100eed:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ef0:	89 ec                	mov    %ebp,%esp
80100ef2:	5d                   	pop    %ebp
80100ef3:	c3                   	ret    
80100ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100ef8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100efb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f00:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100f03:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100f06:	89 ec                	mov    %ebp,%esp
80100f08:	5d                   	pop    %ebp
80100f09:	c3                   	ret    
80100f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f10:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f13:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100f16:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100f19:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f1c:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f1f:	89 ec                	mov    %ebp,%esp
80100f21:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f22:	e9 69 24 00 00       	jmp    80103390 <piperead>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100f27:	c7 04 24 59 72 10 80 	movl   $0x80107259,(%esp)
80100f2e:	e8 9d f4 ff ff       	call   801003d0 <panic>
80100f33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f40 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f40:	55                   	push   %ebp
  if(f->type == FD_INODE){
80100f41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f46:	89 e5                	mov    %esp,%ebp
80100f48:	53                   	push   %ebx
80100f49:	83 ec 14             	sub    $0x14,%esp
80100f4c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f4f:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f52:	74 0c                	je     80100f60 <filestat+0x20>
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
}
80100f54:	83 c4 14             	add    $0x14,%esp
80100f57:	5b                   	pop    %ebx
80100f58:	5d                   	pop    %ebp
80100f59:	c3                   	ret    
80100f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
80100f60:	8b 43 10             	mov    0x10(%ebx),%eax
80100f63:	89 04 24             	mov    %eax,(%esp)
80100f66:	e8 f5 0c 00 00       	call   80101c60 <ilock>
    stati(f->ip, st);
80100f6b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f6e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f72:	8b 43 10             	mov    0x10(%ebx),%eax
80100f75:	89 04 24             	mov    %eax,(%esp)
80100f78:	e8 e3 01 00 00       	call   80101160 <stati>
    iunlock(f->ip);
80100f7d:	8b 43 10             	mov    0x10(%ebx),%eax
80100f80:	89 04 24             	mov    %eax,(%esp)
80100f83:	e8 68 0c 00 00       	call   80101bf0 <iunlock>
    return 0;
  }
  return -1;
}
80100f88:	83 c4 14             	add    $0x14,%esp
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
80100f8b:	31 c0                	xor    %eax,%eax
    return 0;
  }
  return -1;
}
80100f8d:	5b                   	pop    %ebx
80100f8e:	5d                   	pop    %ebp
80100f8f:	c3                   	ret    

80100f90 <filedup>:
}

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f90:	55                   	push   %ebp
80100f91:	89 e5                	mov    %esp,%ebp
80100f93:	53                   	push   %ebx
80100f94:	83 ec 14             	sub    $0x14,%esp
80100f97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f9a:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100fa1:	e8 ea 35 00 00       	call   80104590 <acquire>
  if(f->ref < 1)
80100fa6:	8b 43 04             	mov    0x4(%ebx),%eax
80100fa9:	85 c0                	test   %eax,%eax
80100fab:	7e 1a                	jle    80100fc7 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100fad:	83 c0 01             	add    $0x1,%eax
80100fb0:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100fb3:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100fba:	e8 81 35 00 00       	call   80104540 <release>
  return f;
}
80100fbf:	89 d8                	mov    %ebx,%eax
80100fc1:	83 c4 14             	add    $0x14,%esp
80100fc4:	5b                   	pop    %ebx
80100fc5:	5d                   	pop    %ebp
80100fc6:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100fc7:	c7 04 24 62 72 10 80 	movl   $0x80107262,(%esp)
80100fce:	e8 fd f3 ff ff       	call   801003d0 <panic>
80100fd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fe0 <filealloc>:
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	53                   	push   %ebx
  initlock(&ftable.lock, "ftable");
}

// Allocate a file structure.
struct file*
filealloc(void)
80100fe4:	bb 2c 00 11 80       	mov    $0x8011002c,%ebx
{
80100fe9:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
80100fec:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100ff3:	e8 98 35 00 00       	call   80104590 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
80100ff8:	8b 0d 18 00 11 80    	mov    0x80110018,%ecx
80100ffe:	85 c9                	test   %ecx,%ecx
80101000:	75 11                	jne    80101013 <filealloc+0x33>
80101002:	eb 4a                	jmp    8010104e <filealloc+0x6e>
80101004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101008:	83 c3 18             	add    $0x18,%ebx
8010100b:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80101011:	74 25                	je     80101038 <filealloc+0x58>
    if(f->ref == 0){
80101013:	8b 53 04             	mov    0x4(%ebx),%edx
80101016:	85 d2                	test   %edx,%edx
80101018:	75 ee                	jne    80101008 <filealloc+0x28>
      f->ref = 1;
8010101a:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101021:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80101028:	e8 13 35 00 00       	call   80104540 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
8010102d:	89 d8                	mov    %ebx,%eax
8010102f:	83 c4 14             	add    $0x14,%esp
80101032:	5b                   	pop    %ebx
80101033:	5d                   	pop    %ebp
80101034:	c3                   	ret    
80101035:	8d 76 00             	lea    0x0(%esi),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80101038:	31 db                	xor    %ebx,%ebx
8010103a:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80101041:	e8 fa 34 00 00       	call   80104540 <release>
  return 0;
}
80101046:	89 d8                	mov    %ebx,%eax
80101048:	83 c4 14             	add    $0x14,%esp
8010104b:	5b                   	pop    %ebx
8010104c:	5d                   	pop    %ebp
8010104d:	c3                   	ret    
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
8010104e:	bb 14 00 11 80       	mov    $0x80110014,%ebx
80101053:	eb c5                	jmp    8010101a <filealloc+0x3a>
80101055:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101060 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101060:	55                   	push   %ebp
80101061:	89 e5                	mov    %esp,%ebp
80101063:	83 ec 38             	sub    $0x38,%esp
80101066:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101069:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010106c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010106f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&ftable.lock);
80101072:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80101079:	e8 12 35 00 00       	call   80104590 <acquire>
  if(f->ref < 1)
8010107e:	8b 43 04             	mov    0x4(%ebx),%eax
80101081:	85 c0                	test   %eax,%eax
80101083:	0f 8e a4 00 00 00    	jle    8010112d <fileclose+0xcd>
    panic("fileclose");
  if(--f->ref > 0){
80101089:	83 e8 01             	sub    $0x1,%eax
8010108c:	85 c0                	test   %eax,%eax
8010108e:	89 43 04             	mov    %eax,0x4(%ebx)
80101091:	74 1d                	je     801010b0 <fileclose+0x50>
    release(&ftable.lock);
80101093:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010109a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010109d:	8b 75 f8             	mov    -0x8(%ebp),%esi
801010a0:	8b 7d fc             	mov    -0x4(%ebp),%edi
801010a3:	89 ec                	mov    %ebp,%esp
801010a5:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
801010a6:	e9 95 34 00 00       	jmp    80104540 <release>
801010ab:	90                   	nop
801010ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
801010b0:	8b 43 0c             	mov    0xc(%ebx),%eax
801010b3:	8b 7b 10             	mov    0x10(%ebx),%edi
801010b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010b9:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
801010bd:	88 45 e7             	mov    %al,-0x19(%ebp)
801010c0:	8b 33                	mov    (%ebx),%esi
  f->ref = 0;
801010c2:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  f->type = FD_NONE;
801010c9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  release(&ftable.lock);
801010cf:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
801010d6:	e8 65 34 00 00       	call   80104540 <release>

  if(ff.type == FD_PIPE)
801010db:	83 fe 01             	cmp    $0x1,%esi
801010de:	74 38                	je     80101118 <fileclose+0xb8>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801010e0:	83 fe 02             	cmp    $0x2,%esi
801010e3:	74 13                	je     801010f8 <fileclose+0x98>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801010e5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801010e8:	8b 75 f8             	mov    -0x8(%ebp),%esi
801010eb:	8b 7d fc             	mov    -0x4(%ebp),%edi
801010ee:	89 ec                	mov    %ebp,%esp
801010f0:	5d                   	pop    %ebp
801010f1:	c3                   	ret    
801010f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
801010f8:	e8 b3 1c 00 00       	call   80102db0 <begin_op>
    iput(ff.ip);
801010fd:	89 3c 24             	mov    %edi,(%esp)
80101100:	e8 2b 03 00 00       	call   80101430 <iput>
    end_op();
  }
}
80101105:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101108:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010110b:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010110e:	89 ec                	mov    %ebp,%esp
80101110:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80101111:	e9 6a 1b 00 00       	jmp    80102c80 <end_op>
80101116:	66 90                	xchg   %ax,%ax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80101118:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
8010111c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101120:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101123:	89 04 24             	mov    %eax,(%esp)
80101126:	e8 55 24 00 00       	call   80103580 <pipeclose>
8010112b:	eb b8                	jmp    801010e5 <fileclose+0x85>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
8010112d:	c7 04 24 6a 72 10 80 	movl   $0x8010726a,(%esp)
80101134:	e8 97 f2 ff ff       	call   801003d0 <panic>
80101139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101140 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101140:	55                   	push   %ebp
80101141:	89 e5                	mov    %esp,%ebp
80101143:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80101146:	c7 44 24 04 74 72 10 	movl   $0x80107274,0x4(%esp)
8010114d:	80 
8010114e:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80101155:	e8 a6 32 00 00       	call   80104400 <initlock>
}
8010115a:	c9                   	leave  
8010115b:	c3                   	ret    
8010115c:	00 00                	add    %al,(%eax)
	...

80101160 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101160:	55                   	push   %ebp
80101161:	89 e5                	mov    %esp,%ebp
80101163:	8b 55 08             	mov    0x8(%ebp),%edx
80101166:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101169:	8b 0a                	mov    (%edx),%ecx
8010116b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010116e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101171:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101174:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101178:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010117b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010117f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101183:	8b 52 58             	mov    0x58(%edx),%edx
80101186:	89 50 10             	mov    %edx,0x10(%eax)
}
80101189:	5d                   	pop    %ebp
8010118a:	c3                   	ret    
8010118b:	90                   	nop
8010118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101190 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101190:	55                   	push   %ebp
80101191:	89 e5                	mov    %esp,%ebp
80101193:	53                   	push   %ebx
80101194:	83 ec 14             	sub    $0x14,%esp
80101197:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010119a:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801011a1:	e8 ea 33 00 00       	call   80104590 <acquire>
  ip->ref++;
801011a6:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801011aa:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801011b1:	e8 8a 33 00 00       	call   80104540 <release>
  return ip;
}
801011b6:	89 d8                	mov    %ebx,%eax
801011b8:	83 c4 14             	add    $0x14,%esp
801011bb:	5b                   	pop    %ebx
801011bc:	5d                   	pop    %ebp
801011bd:	c3                   	ret    
801011be:	66 90                	xchg   %ax,%ax

801011c0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801011c0:	55                   	push   %ebp
801011c1:	89 e5                	mov    %esp,%ebp
801011c3:	57                   	push   %edi
801011c4:	89 d7                	mov    %edx,%edi
801011c6:	56                   	push   %esi

// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
801011c7:	31 f6                	xor    %esi,%esi
{
801011c9:	53                   	push   %ebx
801011ca:	89 c3                	mov    %eax,%ebx
801011cc:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
801011cf:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801011d6:	e8 b5 33 00 00       	call   80104590 <acquire>

// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
801011db:	b8 34 0a 11 80       	mov    $0x80110a34,%eax
801011e0:	eb 16                	jmp    801011f8 <iget+0x38>
801011e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801011e8:	85 f6                	test   %esi,%esi
801011ea:	74 3c                	je     80101228 <iget+0x68>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801011ec:	05 90 00 00 00       	add    $0x90,%eax
801011f1:	3d 54 26 11 80       	cmp    $0x80112654,%eax
801011f6:	74 48                	je     80101240 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801011f8:	8b 48 08             	mov    0x8(%eax),%ecx
801011fb:	85 c9                	test   %ecx,%ecx
801011fd:	7e e9                	jle    801011e8 <iget+0x28>
801011ff:	39 18                	cmp    %ebx,(%eax)
80101201:	75 e5                	jne    801011e8 <iget+0x28>
80101203:	39 78 04             	cmp    %edi,0x4(%eax)
80101206:	75 e0                	jne    801011e8 <iget+0x28>
      ip->ref++;
80101208:	83 c1 01             	add    $0x1,%ecx
8010120b:	89 48 08             	mov    %ecx,0x8(%eax)
      release(&icache.lock);
8010120e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101211:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101218:	e8 23 33 00 00       	call   80104540 <release>
      return ip;
8010121d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
80101220:	83 c4 2c             	add    $0x2c,%esp
80101223:	5b                   	pop    %ebx
80101224:	5e                   	pop    %esi
80101225:	5f                   	pop    %edi
80101226:	5d                   	pop    %ebp
80101227:	c3                   	ret    
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101228:	85 c9                	test   %ecx,%ecx
8010122a:	0f 44 f0             	cmove  %eax,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010122d:	05 90 00 00 00       	add    $0x90,%eax
80101232:	3d 54 26 11 80       	cmp    $0x80112654,%eax
80101237:	75 bf                	jne    801011f8 <iget+0x38>
80101239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101240:	85 f6                	test   %esi,%esi
80101242:	74 29                	je     8010126d <iget+0xad>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101244:	89 1e                	mov    %ebx,(%esi)
  ip->inum = inum;
80101246:	89 7e 04             	mov    %edi,0x4(%esi)
  ip->ref = 1;
80101249:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
80101250:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101257:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010125e:	e8 dd 32 00 00       	call   80104540 <release>

  return ip;
}
80101263:	83 c4 2c             	add    $0x2c,%esp
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
80101266:	89 f0                	mov    %esi,%eax

  return ip;
}
80101268:	5b                   	pop    %ebx
80101269:	5e                   	pop    %esi
8010126a:	5f                   	pop    %edi
8010126b:	5d                   	pop    %ebp
8010126c:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
8010126d:	c7 04 24 7b 72 10 80 	movl   $0x8010727b,(%esp)
80101274:	e8 57 f1 ff ff       	call   801003d0 <panic>
80101279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101280 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101280:	55                   	push   %ebp
80101281:	89 e5                	mov    %esp,%ebp
80101283:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101286:	8b 45 0c             	mov    0xc(%ebp),%eax
80101289:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101290:	00 
80101291:	89 44 24 04          	mov    %eax,0x4(%esp)
80101295:	8b 45 08             	mov    0x8(%ebp),%eax
80101298:	89 04 24             	mov    %eax,(%esp)
8010129b:	e8 d0 34 00 00       	call   80104770 <strncmp>
}
801012a0:	c9                   	leave  
801012a1:	c3                   	ret    
801012a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801012b0 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801012b0:	55                   	push   %ebp
801012b1:	89 e5                	mov    %esp,%ebp
801012b3:	56                   	push   %esi
801012b4:	53                   	push   %ebx
801012b5:	83 ec 10             	sub    $0x10,%esp
801012b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801012bb:	8b 43 04             	mov    0x4(%ebx),%eax
801012be:	c1 e8 03             	shr    $0x3,%eax
801012c1:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801012c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801012cb:	8b 03                	mov    (%ebx),%eax
801012cd:	89 04 24             	mov    %eax,(%esp)
801012d0:	e8 3b ee ff ff       	call   80100110 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
801012d5:	0f b7 53 50          	movzwl 0x50(%ebx),%edx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801012d9:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801012db:	8b 43 04             	mov    0x4(%ebx),%eax
801012de:	83 e0 07             	and    $0x7,%eax
801012e1:	c1 e0 06             	shl    $0x6,%eax
801012e4:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801012e8:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801012eb:	0f b7 53 52          	movzwl 0x52(%ebx),%edx
801012ef:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801012f3:	0f b7 53 54          	movzwl 0x54(%ebx),%edx
801012f7:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801012fb:	0f b7 53 56          	movzwl 0x56(%ebx),%edx
801012ff:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101303:	8b 53 58             	mov    0x58(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101306:	83 c3 5c             	add    $0x5c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
80101309:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010130c:	83 c0 0c             	add    $0xc,%eax
8010130f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101313:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010131a:	00 
8010131b:	89 04 24             	mov    %eax,(%esp)
8010131e:	e8 dd 33 00 00       	call   80104700 <memmove>
  log_write(bp);
80101323:	89 34 24             	mov    %esi,(%esp)
80101326:	e8 95 17 00 00       	call   80102ac0 <log_write>
  brelse(bp);
8010132b:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010132e:	83 c4 10             	add    $0x10,%esp
80101331:	5b                   	pop    %ebx
80101332:	5e                   	pop    %esi
80101333:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
80101334:	e9 07 ed ff ff       	jmp    80100040 <brelse>
80101339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101340 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101340:	55                   	push   %ebp
80101341:	89 e5                	mov    %esp,%ebp
80101343:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
80101346:	8b 45 08             	mov    0x8(%ebp),%eax
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101349:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010134c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010134f:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101352:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101359:	00 
8010135a:	89 04 24             	mov    %eax,(%esp)
8010135d:	e8 ae ed ff ff       	call   80100110 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101362:	89 34 24             	mov    %esi,(%esp)
80101365:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
8010136c:	00 
void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;

  bp = bread(dev, 1);
8010136d:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010136f:	8d 40 5c             	lea    0x5c(%eax),%eax
80101372:	89 44 24 04          	mov    %eax,0x4(%esp)
80101376:	e8 85 33 00 00       	call   80104700 <memmove>
  brelse(bp);
}
8010137b:	8b 75 fc             	mov    -0x4(%ebp),%esi
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
8010137e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101381:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80101384:	89 ec                	mov    %ebp,%esp
80101386:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101387:	e9 b4 ec ff ff       	jmp    80100040 <brelse>
8010138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101390 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	83 ec 28             	sub    $0x28,%esp
80101396:	89 75 f8             	mov    %esi,-0x8(%ebp)
80101399:	89 d6                	mov    %edx,%esi
8010139b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010139e:	89 c3                	mov    %eax,%ebx
801013a0:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013a3:	89 04 24             	mov    %eax,(%esp)
801013a6:	c7 44 24 04 e0 09 11 	movl   $0x801109e0,0x4(%esp)
801013ad:	80 
801013ae:	e8 8d ff ff ff       	call   80101340 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801013b3:	89 f0                	mov    %esi,%eax
801013b5:	c1 e8 0c             	shr    $0xc,%eax
801013b8:	03 05 f8 09 11 80    	add    0x801109f8,%eax
801013be:	89 1c 24             	mov    %ebx,(%esp)
  bi = b % BPB;
801013c1:	89 f3                	mov    %esi,%ebx
801013c3:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
801013c9:	89 44 24 04          	mov    %eax,0x4(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
801013cd:	c1 fb 03             	sar    $0x3,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
801013d0:	e8 3b ed ff ff       	call   80100110 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801013d5:	89 f1                	mov    %esi,%ecx
801013d7:	be 01 00 00 00       	mov    $0x1,%esi
801013dc:	83 e1 07             	and    $0x7,%ecx
801013df:	d3 e6                	shl    %cl,%esi
  if((bp->data[bi/8] & m) == 0)
801013e1:	0f b6 54 18 5c       	movzbl 0x5c(%eax,%ebx,1),%edx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
801013e6:	89 c7                	mov    %eax,%edi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
801013e8:	0f b6 c2             	movzbl %dl,%eax
801013eb:	85 f0                	test   %esi,%eax
801013ed:	74 27                	je     80101416 <bfree+0x86>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801013ef:	89 f0                	mov    %esi,%eax
801013f1:	f7 d0                	not    %eax
801013f3:	21 d0                	and    %edx,%eax
801013f5:	88 44 1f 5c          	mov    %al,0x5c(%edi,%ebx,1)
  log_write(bp);
801013f9:	89 3c 24             	mov    %edi,(%esp)
801013fc:	e8 bf 16 00 00       	call   80102ac0 <log_write>
  brelse(bp);
80101401:	89 3c 24             	mov    %edi,(%esp)
80101404:	e8 37 ec ff ff       	call   80100040 <brelse>
}
80101409:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010140c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010140f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101412:	89 ec                	mov    %ebp,%esp
80101414:	5d                   	pop    %ebp
80101415:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101416:	c7 04 24 8b 72 10 80 	movl   $0x8010728b,(%esp)
8010141d:	e8 ae ef ff ff       	call   801003d0 <panic>
80101422:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101430 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101430:	55                   	push   %ebp
80101431:	89 e5                	mov    %esp,%ebp
80101433:	57                   	push   %edi
80101434:	56                   	push   %esi
80101435:	53                   	push   %ebx
80101436:	83 ec 2c             	sub    $0x2c,%esp
80101439:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
8010143c:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101443:	e8 48 31 00 00       	call   80104590 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101448:	8b 46 08             	mov    0x8(%esi),%eax
8010144b:	83 f8 01             	cmp    $0x1,%eax
8010144e:	74 20                	je     80101470 <iput+0x40>
    ip->type = 0;
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
80101450:	83 e8 01             	sub    $0x1,%eax
80101453:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
80101456:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
8010145d:	83 c4 2c             	add    $0x2c,%esp
80101460:	5b                   	pop    %ebx
80101461:	5e                   	pop    %esi
80101462:	5f                   	pop    %edi
80101463:	5d                   	pop    %ebp
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
  release(&icache.lock);
80101464:	e9 d7 30 00 00       	jmp    80104540 <release>
80101469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
// case it has to free the inode.
void
iput(struct inode *ip)
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101470:	f6 46 4c 02          	testb  $0x2,0x4c(%esi)
80101474:	74 da                	je     80101450 <iput+0x20>
80101476:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
8010147b:	75 d3                	jne    80101450 <iput+0x20>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
8010147d:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101484:	89 f3                	mov    %esi,%ebx
80101486:	e8 b5 30 00 00       	call   80104540 <release>
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
8010148b:	8d 7e 30             	lea    0x30(%esi),%edi
8010148e:	eb 07                	jmp    80101497 <iput+0x67>
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
80101490:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101493:	39 fb                	cmp    %edi,%ebx
80101495:	74 19                	je     801014b0 <iput+0x80>
    if(ip->addrs[i]){
80101497:	8b 53 5c             	mov    0x5c(%ebx),%edx
8010149a:	85 d2                	test   %edx,%edx
8010149c:	74 f2                	je     80101490 <iput+0x60>
      bfree(ip->dev, ip->addrs[i]);
8010149e:	8b 06                	mov    (%esi),%eax
801014a0:	e8 eb fe ff ff       	call   80101390 <bfree>
      ip->addrs[i] = 0;
801014a5:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
801014ac:	eb e2                	jmp    80101490 <iput+0x60>
801014ae:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
801014b0:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
801014b6:	85 c0                	test   %eax,%eax
801014b8:	75 3e                	jne    801014f8 <iput+0xc8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801014ba:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
801014c1:	89 34 24             	mov    %esi,(%esp)
801014c4:	e8 e7 fd ff ff       	call   801012b0 <iupdate>
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
801014c9:	66 c7 46 50 00 00    	movw   $0x0,0x50(%esi)
    iupdate(ip);
801014cf:	89 34 24             	mov    %esi,(%esp)
801014d2:	e8 d9 fd ff ff       	call   801012b0 <iupdate>
    acquire(&icache.lock);
801014d7:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801014de:	e8 ad 30 00 00       	call   80104590 <acquire>
    ip->flags = 0;
801014e3:	8b 46 08             	mov    0x8(%esi),%eax
801014e6:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801014ed:	e9 5e ff ff ff       	jmp    80101450 <iput+0x20>
801014f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801014f8:	89 44 24 04          	mov    %eax,0x4(%esp)
801014fc:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
801014fe:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101500:	89 04 24             	mov    %eax,(%esp)
80101503:	e8 08 ec ff ff       	call   80100110 <bread>
    a = (uint*)bp->data;
80101508:	89 c7                	mov    %eax,%edi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010150a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
8010150d:	83 c7 5c             	add    $0x5c,%edi
80101510:	31 c0                	xor    %eax,%eax
80101512:	eb 11                	jmp    80101525 <iput+0xf5>
80101514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(j = 0; j < NINDIRECT; j++){
80101518:	83 c3 01             	add    $0x1,%ebx
8010151b:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80101521:	89 d8                	mov    %ebx,%eax
80101523:	74 10                	je     80101535 <iput+0x105>
      if(a[j])
80101525:	8b 14 87             	mov    (%edi,%eax,4),%edx
80101528:	85 d2                	test   %edx,%edx
8010152a:	74 ec                	je     80101518 <iput+0xe8>
        bfree(ip->dev, a[j]);
8010152c:	8b 06                	mov    (%esi),%eax
8010152e:	e8 5d fe ff ff       	call   80101390 <bfree>
80101533:	eb e3                	jmp    80101518 <iput+0xe8>
    }
    brelse(bp);
80101535:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101538:	89 04 24             	mov    %eax,(%esp)
8010153b:	e8 00 eb ff ff       	call   80100040 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101540:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101546:	8b 06                	mov    (%esi),%eax
80101548:	e8 43 fe ff ff       	call   80101390 <bfree>
    ip->addrs[NDIRECT] = 0;
8010154d:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101554:	00 00 00 
80101557:	e9 5e ff ff ff       	jmp    801014ba <iput+0x8a>
8010155c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101560 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101560:	55                   	push   %ebp
80101561:	89 e5                	mov    %esp,%ebp
80101563:	57                   	push   %edi
80101564:	56                   	push   %esi
80101565:	53                   	push   %ebx
80101566:	83 ec 3c             	sub    $0x3c,%esp
80101569:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010156c:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101571:	85 c0                	test   %eax,%eax
80101573:	0f 84 90 00 00 00    	je     80101609 <balloc+0xa9>
80101579:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101580:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101583:	c1 f8 0c             	sar    $0xc,%eax
80101586:	03 05 f8 09 11 80    	add    0x801109f8,%eax
8010158c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101590:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101593:	89 04 24             	mov    %eax,(%esp)
80101596:	e8 75 eb ff ff       	call   80100110 <bread>
8010159b:	8b 15 e0 09 11 80    	mov    0x801109e0,%edx
801015a1:	8b 5d dc             	mov    -0x24(%ebp),%ebx
801015a4:	89 55 e0             	mov    %edx,-0x20(%ebp)
801015a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801015aa:	31 c0                	xor    %eax,%eax
801015ac:	eb 35                	jmp    801015e3 <balloc+0x83>
801015ae:	66 90                	xchg   %ax,%ax
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801015b0:	89 c1                	mov    %eax,%ecx
801015b2:	bf 01 00 00 00       	mov    $0x1,%edi
801015b7:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801015ba:	89 c2                	mov    %eax,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801015bc:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801015be:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801015c1:	c1 fa 03             	sar    $0x3,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801015c4:	89 7d d4             	mov    %edi,-0x2c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801015c7:	0f b6 74 11 5c       	movzbl 0x5c(%ecx,%edx,1),%esi
801015cc:	89 f1                	mov    %esi,%ecx
801015ce:	0f b6 f9             	movzbl %cl,%edi
801015d1:	85 7d d4             	test   %edi,-0x2c(%ebp)
801015d4:	74 42                	je     80101618 <balloc+0xb8>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801015d6:	83 c0 01             	add    $0x1,%eax
801015d9:	83 c3 01             	add    $0x1,%ebx
801015dc:	3d 00 10 00 00       	cmp    $0x1000,%eax
801015e1:	74 05                	je     801015e8 <balloc+0x88>
801015e3:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
801015e6:	72 c8                	jb     801015b0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801015e8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015eb:	89 14 24             	mov    %edx,(%esp)
801015ee:	e8 4d ea ff ff       	call   80100040 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801015f3:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801015fa:	8b 4d dc             	mov    -0x24(%ebp),%ecx
801015fd:	39 0d e0 09 11 80    	cmp    %ecx,0x801109e0
80101603:	0f 87 77 ff ff ff    	ja     80101580 <balloc+0x20>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101609:	c7 04 24 9e 72 10 80 	movl   $0x8010729e,(%esp)
80101610:	e8 bb ed ff ff       	call   801003d0 <panic>
80101615:	8d 76 00             	lea    0x0(%esi),%esi
80101618:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
8010161b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010161e:	09 f1                	or     %esi,%ecx
80101620:	88 4c 17 5c          	mov    %cl,0x5c(%edi,%edx,1)
        log_write(bp);
80101624:	89 3c 24             	mov    %edi,(%esp)
80101627:	e8 94 14 00 00       	call   80102ac0 <log_write>
        brelse(bp);
8010162c:	89 3c 24             	mov    %edi,(%esp)
8010162f:	e8 0c ea ff ff       	call   80100040 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101634:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101637:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010163b:	89 04 24             	mov    %eax,(%esp)
8010163e:	e8 cd ea ff ff       	call   80100110 <bread>
  memset(bp->data, 0, BSIZE);
80101643:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
8010164a:	00 
8010164b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101652:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101653:	89 c6                	mov    %eax,%esi
  memset(bp->data, 0, BSIZE);
80101655:	8d 40 5c             	lea    0x5c(%eax),%eax
80101658:	89 04 24             	mov    %eax,(%esp)
8010165b:	e8 d0 2f 00 00       	call   80104630 <memset>
  log_write(bp);
80101660:	89 34 24             	mov    %esi,(%esp)
80101663:	e8 58 14 00 00       	call   80102ac0 <log_write>
  brelse(bp);
80101668:	89 34 24             	mov    %esi,(%esp)
8010166b:	e8 d0 e9 ff ff       	call   80100040 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
80101670:	83 c4 3c             	add    $0x3c,%esp
80101673:	89 d8                	mov    %ebx,%eax
80101675:	5b                   	pop    %ebx
80101676:	5e                   	pop    %esi
80101677:	5f                   	pop    %edi
80101678:	5d                   	pop    %ebp
80101679:	c3                   	ret    
8010167a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101680 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	83 ec 38             	sub    $0x38,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101686:	83 fa 0b             	cmp    $0xb,%edx

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101689:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010168c:	89 c3                	mov    %eax,%ebx
8010168e:	89 75 f8             	mov    %esi,-0x8(%ebp)
80101691:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101694:	77 1a                	ja     801016b0 <bmap+0x30>
    if((addr = ip->addrs[bn]) == 0)
80101696:	8d 7a 14             	lea    0x14(%edx),%edi
80101699:	8b 44 b8 0c          	mov    0xc(%eax,%edi,4),%eax
8010169d:	85 c0                	test   %eax,%eax
8010169f:	74 6f                	je     80101710 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801016a1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801016a4:	8b 75 f8             	mov    -0x8(%ebp),%esi
801016a7:	8b 7d fc             	mov    -0x4(%ebp),%edi
801016aa:	89 ec                	mov    %ebp,%esp
801016ac:	5d                   	pop    %ebp
801016ad:	c3                   	ret    
801016ae:	66 90                	xchg   %ax,%ax
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801016b0:	8d 7a f4             	lea    -0xc(%edx),%edi

  if(bn < NINDIRECT){
801016b3:	83 ff 7f             	cmp    $0x7f,%edi
801016b6:	77 7f                	ja     80101737 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801016b8:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801016be:	85 c0                	test   %eax,%eax
801016c0:	74 66                	je     80101728 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801016c2:	89 44 24 04          	mov    %eax,0x4(%esp)
801016c6:	8b 03                	mov    (%ebx),%eax
801016c8:	89 04 24             	mov    %eax,(%esp)
801016cb:	e8 40 ea ff ff       	call   80100110 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801016d0:	8d 7c b8 5c          	lea    0x5c(%eax,%edi,4),%edi

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801016d4:	89 c6                	mov    %eax,%esi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801016d6:	8b 07                	mov    (%edi),%eax
801016d8:	85 c0                	test   %eax,%eax
801016da:	75 17                	jne    801016f3 <bmap+0x73>
      a[bn] = addr = balloc(ip->dev);
801016dc:	8b 03                	mov    (%ebx),%eax
801016de:	e8 7d fe ff ff       	call   80101560 <balloc>
801016e3:	89 07                	mov    %eax,(%edi)
      log_write(bp);
801016e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801016e8:	89 34 24             	mov    %esi,(%esp)
801016eb:	e8 d0 13 00 00       	call   80102ac0 <log_write>
801016f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    }
    brelse(bp);
801016f3:	89 34 24             	mov    %esi,(%esp)
801016f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801016f9:	e8 42 e9 ff ff       	call   80100040 <brelse>
    return addr;
801016fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }

  panic("bmap: out of range");
}
80101701:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101704:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101707:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010170a:	89 ec                	mov    %ebp,%esp
8010170c:	5d                   	pop    %ebp
8010170d:	c3                   	ret    
8010170e:	66 90                	xchg   %ax,%ax
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101710:	8b 03                	mov    (%ebx),%eax
80101712:	e8 49 fe ff ff       	call   80101560 <balloc>
80101717:	89 44 bb 0c          	mov    %eax,0xc(%ebx,%edi,4)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010171b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010171e:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101721:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101724:	89 ec                	mov    %ebp,%esp
80101726:	5d                   	pop    %ebp
80101727:	c3                   	ret    
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101728:	8b 03                	mov    (%ebx),%eax
8010172a:	e8 31 fe ff ff       	call   80101560 <balloc>
8010172f:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101735:	eb 8b                	jmp    801016c2 <bmap+0x42>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101737:	c7 04 24 b4 72 10 80 	movl   $0x801072b4,(%esp)
8010173e:	e8 8d ec ff ff       	call   801003d0 <panic>
80101743:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101750 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	83 ec 38             	sub    $0x38,%esp
80101756:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101759:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010175c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010175f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101762:	89 7d fc             	mov    %edi,-0x4(%ebp)
80101765:	8b 75 10             	mov    0x10(%ebp),%esi
80101768:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010176b:	66 83 7b 50 03       	cmpw   $0x3,0x50(%ebx)
80101770:	74 1e                	je     80101790 <writei+0x40>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101772:	39 73 58             	cmp    %esi,0x58(%ebx)
80101775:	73 41                	jae    801017b8 <writei+0x68>

  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101777:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010177c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010177f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101782:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101785:	89 ec                	mov    %ebp,%esp
80101787:	5d                   	pop    %ebp
80101788:	c3                   	ret    
80101789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101790:	0f b7 43 52          	movzwl 0x52(%ebx),%eax
80101794:	66 83 f8 09          	cmp    $0x9,%ax
80101798:	77 dd                	ja     80101777 <writei+0x27>
8010179a:	98                   	cwtl   
8010179b:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
801017a2:	85 c0                	test   %eax,%eax
801017a4:	74 d1                	je     80101777 <writei+0x27>
      return -1;
    return devsw[ip->major].write(ip, src, n);
801017a6:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
801017a9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801017ac:	8b 75 f8             	mov    -0x8(%ebp),%esi
801017af:	8b 7d fc             	mov    -0x4(%ebp),%edi
801017b2:	89 ec                	mov    %ebp,%esp
801017b4:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
801017b5:	ff e0                	jmp    *%eax
801017b7:	90                   	nop
  }

  if(off > ip->size || off + n < off)
801017b8:	89 f8                	mov    %edi,%eax
801017ba:	01 f0                	add    %esi,%eax
801017bc:	72 b9                	jb     80101777 <writei+0x27>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801017be:	3d 00 18 01 00       	cmp    $0x11800,%eax
801017c3:	77 b2                	ja     80101777 <writei+0x27>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801017c5:	85 ff                	test   %edi,%edi
801017c7:	0f 84 8a 00 00 00    	je     80101857 <writei+0x107>
801017cd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801017d4:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801017d7:	89 7d dc             	mov    %edi,-0x24(%ebp)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801017da:	89 f2                	mov    %esi,%edx
801017dc:	89 d8                	mov    %ebx,%eax
801017de:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801017e1:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801017e6:	e8 95 fe ff ff       	call   80101680 <bmap>
801017eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801017ef:	8b 03                	mov    (%ebx),%eax
801017f1:	89 04 24             	mov    %eax,(%esp)
801017f4:	e8 17 e9 ff ff       	call   80100110 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801017f9:	8b 4d dc             	mov    -0x24(%ebp),%ecx
801017fc:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801017ff:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101801:	89 f0                	mov    %esi,%eax
80101803:	25 ff 01 00 00       	and    $0x1ff,%eax
80101808:	29 c7                	sub    %eax,%edi
8010180a:	39 cf                	cmp    %ecx,%edi
8010180c:	0f 47 f9             	cmova  %ecx,%edi
    memmove(bp->data + off%BSIZE, src, m);
8010180f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101812:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101816:	01 fe                	add    %edi,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101818:	89 55 d8             	mov    %edx,-0x28(%ebp)
8010181b:	89 7c 24 08          	mov    %edi,0x8(%esp)
8010181f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80101823:	89 04 24             	mov    %eax,(%esp)
80101826:	e8 d5 2e 00 00       	call   80104700 <memmove>
    log_write(bp);
8010182b:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010182e:	89 14 24             	mov    %edx,(%esp)
80101831:	e8 8a 12 00 00       	call   80102ac0 <log_write>
    brelse(bp);
80101836:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101839:	89 14 24             	mov    %edx,(%esp)
8010183c:	e8 ff e7 ff ff       	call   80100040 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101841:	01 7d e4             	add    %edi,-0x1c(%ebp)
80101844:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101847:	01 7d e0             	add    %edi,-0x20(%ebp)
8010184a:	39 45 dc             	cmp    %eax,-0x24(%ebp)
8010184d:	77 8b                	ja     801017da <writei+0x8a>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
8010184f:	3b 73 58             	cmp    0x58(%ebx),%esi
80101852:	8b 7d dc             	mov    -0x24(%ebp),%edi
80101855:	77 07                	ja     8010185e <writei+0x10e>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101857:	89 f8                	mov    %edi,%eax
80101859:	e9 1e ff ff ff       	jmp    8010177c <writei+0x2c>
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
8010185e:	89 73 58             	mov    %esi,0x58(%ebx)
    iupdate(ip);
80101861:	89 1c 24             	mov    %ebx,(%esp)
80101864:	e8 47 fa ff ff       	call   801012b0 <iupdate>
  }
  return n;
80101869:	89 f8                	mov    %edi,%eax
8010186b:	e9 0c ff ff ff       	jmp    8010177c <writei+0x2c>

80101870 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	83 ec 38             	sub    $0x38,%esp
80101876:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101879:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010187c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010187f:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101882:	89 7d fc             	mov    %edi,-0x4(%ebp)
80101885:	8b 75 10             	mov    0x10(%ebp),%esi
80101888:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010188b:	66 83 7b 50 03       	cmpw   $0x3,0x50(%ebx)
80101890:	74 1e                	je     801018b0 <readi+0x40>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101892:	8b 43 58             	mov    0x58(%ebx),%eax
80101895:	39 f0                	cmp    %esi,%eax
80101897:	73 3f                	jae    801018d8 <readi+0x68>
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101899:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010189e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801018a1:	8b 75 f8             	mov    -0x8(%ebp),%esi
801018a4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801018a7:	89 ec                	mov    %ebp,%esp
801018a9:	5d                   	pop    %ebp
801018aa:	c3                   	ret    
801018ab:	90                   	nop
801018ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801018b0:	0f b7 43 52          	movzwl 0x52(%ebx),%eax
801018b4:	66 83 f8 09          	cmp    $0x9,%ax
801018b8:	77 df                	ja     80101899 <readi+0x29>
801018ba:	98                   	cwtl   
801018bb:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
801018c2:	85 c0                	test   %eax,%eax
801018c4:	74 d3                	je     80101899 <readi+0x29>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
801018c6:	89 4d 10             	mov    %ecx,0x10(%ebp)
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
801018c9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801018cc:	8b 75 f8             	mov    -0x8(%ebp),%esi
801018cf:	8b 7d fc             	mov    -0x4(%ebp),%edi
801018d2:	89 ec                	mov    %ebp,%esp
801018d4:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
801018d5:	ff e0                	jmp    *%eax
801018d7:	90                   	nop
  }

  if(off > ip->size || off + n < off)
801018d8:	89 ca                	mov    %ecx,%edx
801018da:	01 f2                	add    %esi,%edx
801018dc:	89 55 e0             	mov    %edx,-0x20(%ebp)
801018df:	72 b8                	jb     80101899 <readi+0x29>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801018e1:	89 c2                	mov    %eax,%edx
801018e3:	29 f2                	sub    %esi,%edx
801018e5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
801018e8:	0f 42 ca             	cmovb  %edx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801018eb:	85 c9                	test   %ecx,%ecx
801018ed:	74 7e                	je     8010196d <readi+0xfd>
801018ef:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801018f6:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018f9:	89 4d dc             	mov    %ecx,-0x24(%ebp)
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101900:	89 f2                	mov    %esi,%edx
80101902:	89 d8                	mov    %ebx,%eax
80101904:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101907:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010190c:	e8 6f fd ff ff       	call   80101680 <bmap>
80101911:	89 44 24 04          	mov    %eax,0x4(%esp)
80101915:	8b 03                	mov    (%ebx),%eax
80101917:	89 04 24             	mov    %eax,(%esp)
8010191a:	e8 f1 e7 ff ff       	call   80100110 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010191f:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101922:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101925:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101927:	89 f0                	mov    %esi,%eax
80101929:	25 ff 01 00 00       	and    $0x1ff,%eax
8010192e:	29 c7                	sub    %eax,%edi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101930:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101934:	39 cf                	cmp    %ecx,%edi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101936:	89 44 24 04          	mov    %eax,0x4(%esp)
8010193a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
8010193d:	0f 47 f9             	cmova  %ecx,%edi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101940:	89 55 d8             	mov    %edx,-0x28(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101943:	01 fe                	add    %edi,%esi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101945:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101949:	89 04 24             	mov    %eax,(%esp)
8010194c:	e8 af 2d 00 00       	call   80104700 <memmove>
    brelse(bp);
80101951:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101954:	89 14 24             	mov    %edx,(%esp)
80101957:	e8 e4 e6 ff ff       	call   80100040 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010195c:	01 7d e4             	add    %edi,-0x1c(%ebp)
8010195f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101962:	01 7d e0             	add    %edi,-0x20(%ebp)
80101965:	39 55 dc             	cmp    %edx,-0x24(%ebp)
80101968:	77 96                	ja     80101900 <readi+0x90>
8010196a:	8b 4d dc             	mov    -0x24(%ebp),%ecx
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
8010196d:	89 c8                	mov    %ecx,%eax
8010196f:	e9 2a ff ff ff       	jmp    8010189e <readi+0x2e>
80101974:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010197a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101980 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	57                   	push   %edi
80101984:	56                   	push   %esi
80101985:	53                   	push   %ebx
80101986:	83 ec 2c             	sub    $0x2c,%esp
80101989:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010198c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101991:	0f 85 8c 00 00 00    	jne    80101a23 <dirlookup+0xa3>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101997:	8b 4b 58             	mov    0x58(%ebx),%ecx
8010199a:	85 c9                	test   %ecx,%ecx
8010199c:	74 4c                	je     801019ea <dirlookup+0x6a>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
8010199e:	8d 7d d8             	lea    -0x28(%ebp),%edi
801019a1:	31 f6                	xor    %esi,%esi
801019a3:	90                   	nop
801019a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801019a8:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801019af:	00 
801019b0:	89 74 24 08          	mov    %esi,0x8(%esp)
801019b4:	89 7c 24 04          	mov    %edi,0x4(%esp)
801019b8:	89 1c 24             	mov    %ebx,(%esp)
801019bb:	e8 b0 fe ff ff       	call   80101870 <readi>
801019c0:	83 f8 10             	cmp    $0x10,%eax
801019c3:	75 52                	jne    80101a17 <dirlookup+0x97>
      panic("dirlink read");
    if(de.inum == 0)
801019c5:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801019ca:	74 16                	je     801019e2 <dirlookup+0x62>
      continue;
    if(namecmp(name, de.name) == 0){
801019cc:	8d 45 da             	lea    -0x26(%ebp),%eax
801019cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801019d3:	8b 45 0c             	mov    0xc(%ebp),%eax
801019d6:	89 04 24             	mov    %eax,(%esp)
801019d9:	e8 a2 f8 ff ff       	call   80101280 <namecmp>
801019de:	85 c0                	test   %eax,%eax
801019e0:	74 16                	je     801019f8 <dirlookup+0x78>
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801019e2:	83 c6 10             	add    $0x10,%esi
801019e5:	39 73 58             	cmp    %esi,0x58(%ebx)
801019e8:	77 be                	ja     801019a8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801019ea:	83 c4 2c             	add    $0x2c,%esp
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801019ed:	31 c0                	xor    %eax,%eax
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801019ef:	5b                   	pop    %ebx
801019f0:	5e                   	pop    %esi
801019f1:	5f                   	pop    %edi
801019f2:	5d                   	pop    %ebp
801019f3:	c3                   	ret    
801019f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("dirlink read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
      // entry matches path element
      if(poff)
801019f8:	8b 55 10             	mov    0x10(%ebp),%edx
801019fb:	85 d2                	test   %edx,%edx
801019fd:	74 05                	je     80101a04 <dirlookup+0x84>
        *poff = off;
801019ff:	8b 45 10             	mov    0x10(%ebp),%eax
80101a02:	89 30                	mov    %esi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101a04:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101a08:	8b 03                	mov    (%ebx),%eax
80101a0a:	e8 b1 f7 ff ff       	call   801011c0 <iget>
    }
  }

  return 0;
}
80101a0f:	83 c4 2c             	add    $0x2c,%esp
80101a12:	5b                   	pop    %ebx
80101a13:	5e                   	pop    %esi
80101a14:	5f                   	pop    %edi
80101a15:	5d                   	pop    %ebp
80101a16:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101a17:	c7 04 24 d9 72 10 80 	movl   $0x801072d9,(%esp)
80101a1e:	e8 ad e9 ff ff       	call   801003d0 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101a23:	c7 04 24 c7 72 10 80 	movl   $0x801072c7,(%esp)
80101a2a:	e8 a1 e9 ff ff       	call   801003d0 <panic>
80101a2f:	90                   	nop

80101a30 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101a30:	55                   	push   %ebp
80101a31:	89 e5                	mov    %esp,%ebp
80101a33:	57                   	push   %edi
80101a34:	56                   	push   %esi
80101a35:	53                   	push   %ebx
80101a36:	83 ec 2c             	sub    $0x2c,%esp
80101a39:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101a3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a3f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101a46:	00 
80101a47:	89 34 24             	mov    %esi,(%esp)
80101a4a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a4e:	e8 2d ff ff ff       	call   80101980 <dirlookup>
80101a53:	85 c0                	test   %eax,%eax
80101a55:	0f 85 89 00 00 00    	jne    80101ae4 <dirlink+0xb4>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101a5b:	8b 5e 58             	mov    0x58(%esi),%ebx
80101a5e:	85 db                	test   %ebx,%ebx
80101a60:	0f 84 8d 00 00 00    	je     80101af3 <dirlink+0xc3>
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
    return -1;
80101a66:	8d 7d d8             	lea    -0x28(%ebp),%edi
80101a69:	31 db                	xor    %ebx,%ebx
80101a6b:	eb 0b                	jmp    80101a78 <dirlink+0x48>
80101a6d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101a70:	83 c3 10             	add    $0x10,%ebx
80101a73:	39 5e 58             	cmp    %ebx,0x58(%esi)
80101a76:	76 24                	jbe    80101a9c <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101a78:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101a7f:	00 
80101a80:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101a84:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101a88:	89 34 24             	mov    %esi,(%esp)
80101a8b:	e8 e0 fd ff ff       	call   80101870 <readi>
80101a90:	83 f8 10             	cmp    $0x10,%eax
80101a93:	75 65                	jne    80101afa <dirlink+0xca>
      panic("dirlink read");
    if(de.inum == 0)
80101a95:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101a9a:	75 d4                	jne    80101a70 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a9f:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101aa6:	00 
80101aa7:	89 44 24 04          	mov    %eax,0x4(%esp)
80101aab:	8d 45 da             	lea    -0x26(%ebp),%eax
80101aae:	89 04 24             	mov    %eax,(%esp)
80101ab1:	e8 1a 2d 00 00       	call   801047d0 <strncpy>
  de.inum = inum;
80101ab6:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ab9:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101ac0:	00 
80101ac1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101ac5:	89 7c 24 04          	mov    %edi,0x4(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101ac9:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101acd:	89 34 24             	mov    %esi,(%esp)
80101ad0:	e8 7b fc ff ff       	call   80101750 <writei>
80101ad5:	83 f8 10             	cmp    $0x10,%eax
80101ad8:	75 2c                	jne    80101b06 <dirlink+0xd6>
    panic("dirlink");
80101ada:	31 c0                	xor    %eax,%eax

  return 0;
}
80101adc:	83 c4 2c             	add    $0x2c,%esp
80101adf:	5b                   	pop    %ebx
80101ae0:	5e                   	pop    %esi
80101ae1:	5f                   	pop    %edi
80101ae2:	5d                   	pop    %ebp
80101ae3:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101ae4:	89 04 24             	mov    %eax,(%esp)
80101ae7:	e8 44 f9 ff ff       	call   80101430 <iput>
80101aec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
80101af1:	eb e9                	jmp    80101adc <dirlink+0xac>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101af3:	8d 7d d8             	lea    -0x28(%ebp),%edi
80101af6:	31 db                	xor    %ebx,%ebx
80101af8:	eb a2                	jmp    80101a9c <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101afa:	c7 04 24 d9 72 10 80 	movl   $0x801072d9,(%esp)
80101b01:	e8 ca e8 ff ff       	call   801003d0 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101b06:	c7 04 24 ea 78 10 80 	movl   $0x801078ea,(%esp)
80101b0d:	e8 be e8 ff ff       	call   801003d0 <panic>
80101b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b20 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	57                   	push   %edi
80101b24:	56                   	push   %esi
80101b25:	53                   	push   %ebx
80101b26:	83 ec 2c             	sub    $0x2c,%esp
80101b29:	8b 45 08             	mov    0x8(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101b2c:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101b33:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101b36:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
80101b3a:	66 89 45 e2          	mov    %ax,-0x1e(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101b3e:	0f 86 95 00 00 00    	jbe    80101bd9 <ialloc+0xb9>
80101b44:	be 01 00 00 00       	mov    $0x1,%esi
80101b49:	bb 01 00 00 00       	mov    $0x1,%ebx
80101b4e:	eb 15                	jmp    80101b65 <ialloc+0x45>
80101b50:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101b53:	89 3c 24             	mov    %edi,(%esp)
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101b56:	89 de                	mov    %ebx,%esi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101b58:	e8 e3 e4 ff ff       	call   80100040 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101b5d:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
80101b63:	76 74                	jbe    80101bd9 <ialloc+0xb9>
    bp = bread(dev, IBLOCK(inum, sb));
80101b65:	89 f0                	mov    %esi,%eax
80101b67:	c1 e8 03             	shr    $0x3,%eax
80101b6a:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101b70:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b77:	89 04 24             	mov    %eax,(%esp)
80101b7a:	e8 91 e5 ff ff       	call   80100110 <bread>
80101b7f:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
80101b81:	89 f0                	mov    %esi,%eax
80101b83:	83 e0 07             	and    $0x7,%eax
80101b86:	c1 e0 06             	shl    $0x6,%eax
80101b89:	8d 54 07 5c          	lea    0x5c(%edi,%eax,1),%edx
    if(dip->type == 0){  // a free inode
80101b8d:	66 83 3a 00          	cmpw   $0x0,(%edx)
80101b91:	75 bd                	jne    80101b50 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101b93:	89 14 24             	mov    %edx,(%esp)
80101b96:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101b99:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
80101ba0:	00 
80101ba1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101ba8:	00 
80101ba9:	e8 82 2a 00 00       	call   80104630 <memset>
      dip->type = type;
80101bae:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101bb1:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
80101bb5:	66 89 02             	mov    %ax,(%edx)
      log_write(bp);   // mark it allocated on the disk
80101bb8:	89 3c 24             	mov    %edi,(%esp)
80101bbb:	e8 00 0f 00 00       	call   80102ac0 <log_write>
      brelse(bp);
80101bc0:	89 3c 24             	mov    %edi,(%esp)
80101bc3:	e8 78 e4 ff ff       	call   80100040 <brelse>
      return iget(dev, inum);
80101bc8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101bcb:	89 f2                	mov    %esi,%edx
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101bcd:	83 c4 2c             	add    $0x2c,%esp
80101bd0:	5b                   	pop    %ebx
80101bd1:	5e                   	pop    %esi
80101bd2:	5f                   	pop    %edi
80101bd3:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101bd4:	e9 e7 f5 ff ff       	jmp    801011c0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101bd9:	c7 04 24 e6 72 10 80 	movl   $0x801072e6,(%esp)
80101be0:	e8 eb e7 ff ff       	call   801003d0 <panic>
80101be5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bf0 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	83 ec 18             	sub    $0x18,%esp
80101bf6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80101bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101bfc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101bff:	85 db                	test   %ebx,%ebx
80101c01:	74 27                	je     80101c2a <iunlock+0x3a>
80101c03:	8d 73 0c             	lea    0xc(%ebx),%esi
80101c06:	89 34 24             	mov    %esi,(%esp)
80101c09:	e8 e2 26 00 00       	call   801042f0 <holdingsleep>
80101c0e:	85 c0                	test   %eax,%eax
80101c10:	74 18                	je     80101c2a <iunlock+0x3a>
80101c12:	8b 43 08             	mov    0x8(%ebx),%eax
80101c15:	85 c0                	test   %eax,%eax
80101c17:	7e 11                	jle    80101c2a <iunlock+0x3a>
    panic("iunlock");

  releasesleep(&ip->lock);
80101c19:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101c1c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80101c1f:	8b 75 fc             	mov    -0x4(%ebp),%esi
80101c22:	89 ec                	mov    %ebp,%esp
80101c24:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
80101c25:	e9 f6 26 00 00       	jmp    80104320 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101c2a:	c7 04 24 f8 72 10 80 	movl   $0x801072f8,(%esp)
80101c31:	e8 9a e7 ff ff       	call   801003d0 <panic>
80101c36:	8d 76 00             	lea    0x0(%esi),%esi
80101c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c40 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101c40:	55                   	push   %ebp
80101c41:	89 e5                	mov    %esp,%ebp
80101c43:	53                   	push   %ebx
80101c44:	83 ec 14             	sub    $0x14,%esp
80101c47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101c4a:	89 1c 24             	mov    %ebx,(%esp)
80101c4d:	e8 9e ff ff ff       	call   80101bf0 <iunlock>
  iput(ip);
80101c52:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101c55:	83 c4 14             	add    $0x14,%esp
80101c58:	5b                   	pop    %ebx
80101c59:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101c5a:	e9 d1 f7 ff ff       	jmp    80101430 <iput>
80101c5f:	90                   	nop

80101c60 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	56                   	push   %esi
80101c64:	53                   	push   %ebx
80101c65:	83 ec 10             	sub    $0x10,%esp
80101c68:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101c6b:	85 db                	test   %ebx,%ebx
80101c6d:	0f 84 b0 00 00 00    	je     80101d23 <ilock+0xc3>
80101c73:	8b 53 08             	mov    0x8(%ebx),%edx
80101c76:	85 d2                	test   %edx,%edx
80101c78:	0f 8e a5 00 00 00    	jle    80101d23 <ilock+0xc3>
    panic("ilock");

  acquiresleep(&ip->lock);
80101c7e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101c81:	89 04 24             	mov    %eax,(%esp)
80101c84:	e8 d7 26 00 00       	call   80104360 <acquiresleep>

  if(!(ip->flags & I_VALID)){
80101c89:	f6 43 4c 02          	testb  $0x2,0x4c(%ebx)
80101c8d:	74 09                	je     80101c98 <ilock+0x38>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101c8f:	83 c4 10             	add    $0x10,%esp
80101c92:	5b                   	pop    %ebx
80101c93:	5e                   	pop    %esi
80101c94:	5d                   	pop    %ebp
80101c95:	c3                   	ret    
80101c96:	66 90                	xchg   %ax,%ax
    panic("ilock");

  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c98:	8b 43 04             	mov    0x4(%ebx),%eax
80101c9b:	c1 e8 03             	shr    $0x3,%eax
80101c9e:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101ca4:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ca8:	8b 03                	mov    (%ebx),%eax
80101caa:	89 04 24             	mov    %eax,(%esp)
80101cad:	e8 5e e4 ff ff       	call   80100110 <bread>
80101cb2:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101cb4:	8b 43 04             	mov    0x4(%ebx),%eax
80101cb7:	83 e0 07             	and    $0x7,%eax
80101cba:	c1 e0 06             	shl    $0x6,%eax
80101cbd:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101cc1:	0f b7 10             	movzwl (%eax),%edx
80101cc4:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101cc8:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101ccc:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101cd0:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101cd4:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101cd8:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101cdc:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101ce0:	8b 50 08             	mov    0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101ce3:	83 c0 0c             	add    $0xc,%eax
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
80101ce6:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101ce9:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ced:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101cf0:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101cf7:	00 
80101cf8:	89 04 24             	mov    %eax,(%esp)
80101cfb:	e8 00 2a 00 00       	call   80104700 <memmove>
    brelse(bp);
80101d00:	89 34 24             	mov    %esi,(%esp)
80101d03:	e8 38 e3 ff ff       	call   80100040 <brelse>
    ip->flags |= I_VALID;
80101d08:	83 4b 4c 02          	orl    $0x2,0x4c(%ebx)
    if(ip->type == 0)
80101d0c:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101d11:	0f 85 78 ff ff ff    	jne    80101c8f <ilock+0x2f>
      panic("ilock: no type");
80101d17:	c7 04 24 06 73 10 80 	movl   $0x80107306,(%esp)
80101d1e:	e8 ad e6 ff ff       	call   801003d0 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101d23:	c7 04 24 00 73 10 80 	movl   $0x80107300,(%esp)
80101d2a:	e8 a1 e6 ff ff       	call   801003d0 <panic>
80101d2f:	90                   	nop

80101d30 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d30:	55                   	push   %ebp
80101d31:	89 e5                	mov    %esp,%ebp
80101d33:	57                   	push   %edi
80101d34:	56                   	push   %esi
80101d35:	53                   	push   %ebx
80101d36:	89 c3                	mov    %eax,%ebx
80101d38:	83 ec 2c             	sub    $0x2c,%esp
80101d3b:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101d3e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101d41:	80 38 2f             	cmpb   $0x2f,(%eax)
80101d44:	0f 84 14 01 00 00    	je     80101e5e <namex+0x12e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101d4a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101d50:	8b 40 68             	mov    0x68(%eax),%eax
80101d53:	89 04 24             	mov    %eax,(%esp)
80101d56:	e8 35 f4 ff ff       	call   80101190 <idup>
80101d5b:	89 c7                	mov    %eax,%edi
80101d5d:	eb 04                	jmp    80101d63 <namex+0x33>
80101d5f:	90                   	nop
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101d60:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101d63:	0f b6 03             	movzbl (%ebx),%eax
80101d66:	3c 2f                	cmp    $0x2f,%al
80101d68:	74 f6                	je     80101d60 <namex+0x30>
    path++;
  if(*path == 0)
80101d6a:	84 c0                	test   %al,%al
80101d6c:	75 1a                	jne    80101d88 <namex+0x58>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d6e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101d71:	85 c9                	test   %ecx,%ecx
80101d73:	0f 85 0d 01 00 00    	jne    80101e86 <namex+0x156>
    iput(ip);
    return 0;
  }
  return ip;
}
80101d79:	83 c4 2c             	add    $0x2c,%esp
80101d7c:	89 f8                	mov    %edi,%eax
80101d7e:	5b                   	pop    %ebx
80101d7f:	5e                   	pop    %esi
80101d80:	5f                   	pop    %edi
80101d81:	5d                   	pop    %ebp
80101d82:	c3                   	ret    
80101d83:	90                   	nop
80101d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d88:	3c 2f                	cmp    $0x2f,%al
80101d8a:	0f 84 91 00 00 00    	je     80101e21 <namex+0xf1>
80101d90:	89 de                	mov    %ebx,%esi
80101d92:	eb 08                	jmp    80101d9c <namex+0x6c>
80101d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d98:	3c 2f                	cmp    $0x2f,%al
80101d9a:	74 0a                	je     80101da6 <namex+0x76>
    path++;
80101d9c:	83 c6 01             	add    $0x1,%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d9f:	0f b6 06             	movzbl (%esi),%eax
80101da2:	84 c0                	test   %al,%al
80101da4:	75 f2                	jne    80101d98 <namex+0x68>
80101da6:	89 f2                	mov    %esi,%edx
80101da8:	29 da                	sub    %ebx,%edx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101daa:	83 fa 0d             	cmp    $0xd,%edx
80101dad:	7e 79                	jle    80101e28 <namex+0xf8>
    memmove(name, s, DIRSIZ);
80101daf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101db2:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101db9:	00 
80101dba:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101dbe:	89 04 24             	mov    %eax,(%esp)
80101dc1:	e8 3a 29 00 00       	call   80104700 <memmove>
80101dc6:	eb 03                	jmp    80101dcb <namex+0x9b>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
    path++;
80101dc8:	83 c6 01             	add    $0x1,%esi
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101dcb:	80 3e 2f             	cmpb   $0x2f,(%esi)
80101dce:	74 f8                	je     80101dc8 <namex+0x98>
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
80101dd0:	85 f6                	test   %esi,%esi
80101dd2:	74 9a                	je     80101d6e <namex+0x3e>
    ilock(ip);
80101dd4:	89 3c 24             	mov    %edi,(%esp)
80101dd7:	e8 84 fe ff ff       	call   80101c60 <ilock>
    if(ip->type != T_DIR){
80101ddc:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
80101de1:	75 67                	jne    80101e4a <namex+0x11a>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101de3:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101de6:	85 db                	test   %ebx,%ebx
80101de8:	74 09                	je     80101df3 <namex+0xc3>
80101dea:	80 3e 00             	cmpb   $0x0,(%esi)
80101ded:	0f 84 81 00 00 00    	je     80101e74 <namex+0x144>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101df3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101df6:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101dfd:	00 
80101dfe:	89 3c 24             	mov    %edi,(%esp)
80101e01:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e05:	e8 76 fb ff ff       	call   80101980 <dirlookup>
80101e0a:	85 c0                	test   %eax,%eax
80101e0c:	89 c3                	mov    %eax,%ebx
80101e0e:	74 3a                	je     80101e4a <namex+0x11a>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
80101e10:	89 3c 24             	mov    %edi,(%esp)
80101e13:	89 df                	mov    %ebx,%edi
80101e15:	89 f3                	mov    %esi,%ebx
80101e17:	e8 24 fe ff ff       	call   80101c40 <iunlockput>
80101e1c:	e9 42 ff ff ff       	jmp    80101d63 <namex+0x33>
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101e21:	89 de                	mov    %ebx,%esi
80101e23:	31 d2                	xor    %edx,%edx
80101e25:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101e28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e2b:	89 54 24 08          	mov    %edx,0x8(%esp)
80101e2f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e32:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101e36:	89 04 24             	mov    %eax,(%esp)
80101e39:	e8 c2 28 00 00       	call   80104700 <memmove>
    name[len] = 0;
80101e3e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e44:	c6 04 10 00          	movb   $0x0,(%eax,%edx,1)
80101e48:	eb 81                	jmp    80101dcb <namex+0x9b>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
80101e4a:	89 3c 24             	mov    %edi,(%esp)
80101e4d:	31 ff                	xor    %edi,%edi
80101e4f:	e8 ec fd ff ff       	call   80101c40 <iunlockput>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e54:	83 c4 2c             	add    $0x2c,%esp
80101e57:	89 f8                	mov    %edi,%eax
80101e59:	5b                   	pop    %ebx
80101e5a:	5e                   	pop    %esi
80101e5b:	5f                   	pop    %edi
80101e5c:	5d                   	pop    %ebp
80101e5d:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101e5e:	ba 01 00 00 00       	mov    $0x1,%edx
80101e63:	b8 01 00 00 00       	mov    $0x1,%eax
80101e68:	e8 53 f3 ff ff       	call   801011c0 <iget>
80101e6d:	89 c7                	mov    %eax,%edi
80101e6f:	e9 ef fe ff ff       	jmp    80101d63 <namex+0x33>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101e74:	89 3c 24             	mov    %edi,(%esp)
80101e77:	e8 74 fd ff ff       	call   80101bf0 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e7c:	83 c4 2c             	add    $0x2c,%esp
80101e7f:	89 f8                	mov    %edi,%eax
80101e81:	5b                   	pop    %ebx
80101e82:	5e                   	pop    %esi
80101e83:	5f                   	pop    %edi
80101e84:	5d                   	pop    %ebp
80101e85:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101e86:	89 3c 24             	mov    %edi,(%esp)
80101e89:	31 ff                	xor    %edi,%edi
80101e8b:	e8 a0 f5 ff ff       	call   80101430 <iput>
    return 0;
80101e90:	e9 e4 fe ff ff       	jmp    80101d79 <namex+0x49>
80101e95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ea0 <nameiparent>:
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101ea0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ea1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101ea6:	89 e5                	mov    %esp,%ebp
80101ea8:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
80101eab:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101eae:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101eb1:	c9                   	leave  
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101eb2:	e9 79 fe ff ff       	jmp    80101d30 <namex>
80101eb7:	89 f6                	mov    %esi,%esi
80101eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ec0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101ec0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ec1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101ec3:	89 e5                	mov    %esp,%ebp
80101ec5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ec8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ecb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ece:	e8 5d fe ff ff       	call   80101d30 <namex>
}
80101ed3:	c9                   	leave  
80101ed4:	c3                   	ret    
80101ed5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101ee0:	55                   	push   %ebp
80101ee1:	89 e5                	mov    %esp,%ebp
80101ee3:	53                   	push   %ebx
  int i = 0;
  
  initlock(&icache.lock, "icache");
80101ee4:	31 db                	xor    %ebx,%ebx
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101ee6:	83 ec 24             	sub    $0x24,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
80101ee9:	c7 44 24 04 15 73 10 	movl   $0x80107315,0x4(%esp)
80101ef0:	80 
80101ef1:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101ef8:	e8 03 25 00 00       	call   80104400 <initlock>
80101efd:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101f00:	8d 04 db             	lea    (%ebx,%ebx,8),%eax
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101f03:	83 c3 01             	add    $0x1,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
80101f06:	c1 e0 04             	shl    $0x4,%eax
80101f09:	05 40 0a 11 80       	add    $0x80110a40,%eax
80101f0e:	c7 44 24 04 1c 73 10 	movl   $0x8010731c,0x4(%esp)
80101f15:	80 
80101f16:	89 04 24             	mov    %eax,(%esp)
80101f19:	e8 a2 24 00 00       	call   801043c0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101f1e:	83 fb 32             	cmp    $0x32,%ebx
80101f21:	75 dd                	jne    80101f00 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }
  
  readsb(dev, &sb);
80101f23:	8b 45 08             	mov    0x8(%ebp),%eax
80101f26:	c7 44 24 04 e0 09 11 	movl   $0x801109e0,0x4(%esp)
80101f2d:	80 
80101f2e:	89 04 24             	mov    %eax,(%esp)
80101f31:	e8 0a f4 ff ff       	call   80101340 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101f36:	a1 f8 09 11 80       	mov    0x801109f8,%eax
80101f3b:	c7 04 24 24 73 10 80 	movl   $0x80107324,(%esp)
80101f42:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101f46:	a1 f4 09 11 80       	mov    0x801109f4,%eax
80101f4b:	89 44 24 18          	mov    %eax,0x18(%esp)
80101f4f:	a1 f0 09 11 80       	mov    0x801109f0,%eax
80101f54:	89 44 24 14          	mov    %eax,0x14(%esp)
80101f58:	a1 ec 09 11 80       	mov    0x801109ec,%eax
80101f5d:	89 44 24 10          	mov    %eax,0x10(%esp)
80101f61:	a1 e8 09 11 80       	mov    0x801109e8,%eax
80101f66:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101f6a:	a1 e4 09 11 80       	mov    0x801109e4,%eax
80101f6f:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f73:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101f78:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f7c:	e8 ef e8 ff ff       	call   80100870 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101f81:	83 c4 24             	add    $0x24,%esp
80101f84:	5b                   	pop    %ebx
80101f85:	5d                   	pop    %ebp
80101f86:	c3                   	ret    
	...

80101f90 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f90:	55                   	push   %ebp
80101f91:	89 c1                	mov    %eax,%ecx
80101f93:	89 e5                	mov    %esp,%ebp
80101f95:	56                   	push   %esi
80101f96:	53                   	push   %ebx
80101f97:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80101f9a:	85 c0                	test   %eax,%eax
80101f9c:	0f 84 99 00 00 00    	je     8010203b <idestart+0xab>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101fa2:	8b 58 08             	mov    0x8(%eax),%ebx
80101fa5:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101fab:	0f 87 7e 00 00 00    	ja     8010202f <idestart+0x9f>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fb1:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fb6:	66 90                	xchg   %ax,%ax
80101fb8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101fb9:	25 c0 00 00 00       	and    $0xc0,%eax
80101fbe:	83 f8 40             	cmp    $0x40,%eax
80101fc1:	75 f5                	jne    80101fb8 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fc3:	31 f6                	xor    %esi,%esi
80101fc5:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101fca:	89 f0                	mov    %esi,%eax
80101fcc:	ee                   	out    %al,(%dx)
80101fcd:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101fd2:	b8 01 00 00 00       	mov    $0x1,%eax
80101fd7:	ee                   	out    %al,(%dx)
80101fd8:	b2 f3                	mov    $0xf3,%dl
80101fda:	89 d8                	mov    %ebx,%eax
80101fdc:	ee                   	out    %al,(%dx)
80101fdd:	89 d8                	mov    %ebx,%eax
80101fdf:	b2 f4                	mov    $0xf4,%dl
80101fe1:	c1 f8 08             	sar    $0x8,%eax
80101fe4:	ee                   	out    %al,(%dx)
80101fe5:	b2 f5                	mov    $0xf5,%dl
80101fe7:	89 f0                	mov    %esi,%eax
80101fe9:	ee                   	out    %al,(%dx)
80101fea:	8b 41 04             	mov    0x4(%ecx),%eax
80101fed:	b2 f6                	mov    $0xf6,%dl
80101fef:	83 e0 01             	and    $0x1,%eax
80101ff2:	c1 e0 04             	shl    $0x4,%eax
80101ff5:	83 c8 e0             	or     $0xffffffe0,%eax
80101ff8:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101ff9:	f6 01 04             	testb  $0x4,(%ecx)
80101ffc:	75 12                	jne    80102010 <idestart+0x80>
80101ffe:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102003:	b8 20 00 00 00       	mov    $0x20,%eax
80102008:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102009:	83 c4 10             	add    $0x10,%esp
8010200c:	5b                   	pop    %ebx
8010200d:	5e                   	pop    %esi
8010200e:	5d                   	pop    %ebp
8010200f:	c3                   	ret    
80102010:	b2 f7                	mov    $0xf7,%dl
80102012:	b8 30 00 00 00       	mov    $0x30,%eax
80102017:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102018:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010201d:	8d 71 5c             	lea    0x5c(%ecx),%esi
80102020:	b9 80 00 00 00       	mov    $0x80,%ecx
80102025:	fc                   	cld    
80102026:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102028:	83 c4 10             	add    $0x10,%esp
8010202b:	5b                   	pop    %ebx
8010202c:	5e                   	pop    %esi
8010202d:	5d                   	pop    %ebp
8010202e:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010202f:	c7 04 24 80 73 10 80 	movl   $0x80107380,(%esp)
80102036:	e8 95 e3 ff ff       	call   801003d0 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010203b:	c7 04 24 77 73 10 80 	movl   $0x80107377,(%esp)
80102042:	e8 89 e3 ff ff       	call   801003d0 <panic>
80102047:	89 f6                	mov    %esi,%esi
80102049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102050 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102050:	55                   	push   %ebp
80102051:	89 e5                	mov    %esp,%ebp
80102053:	53                   	push   %ebx
80102054:	83 ec 14             	sub    $0x14,%esp
80102057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010205a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010205d:	89 04 24             	mov    %eax,(%esp)
80102060:	e8 8b 22 00 00       	call   801042f0 <holdingsleep>
80102065:	85 c0                	test   %eax,%eax
80102067:	0f 84 8f 00 00 00    	je     801020fc <iderw+0xac>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010206d:	8b 03                	mov    (%ebx),%eax
8010206f:	83 e0 06             	and    $0x6,%eax
80102072:	83 f8 02             	cmp    $0x2,%eax
80102075:	0f 84 99 00 00 00    	je     80102114 <iderw+0xc4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010207b:	8b 53 04             	mov    0x4(%ebx),%edx
8010207e:	85 d2                	test   %edx,%edx
80102080:	74 09                	je     8010208b <iderw+0x3b>
80102082:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80102087:	85 c0                	test   %eax,%eax
80102089:	74 7d                	je     80102108 <iderw+0xb8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010208b:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102092:	e8 f9 24 00 00       	call   80104590 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102097:	ba b4 a5 10 80       	mov    $0x8010a5b4,%edx
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
8010209c:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
801020a3:	a1 b4 a5 10 80       	mov    0x8010a5b4,%eax
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801020a8:	85 c0                	test   %eax,%eax
801020aa:	74 0e                	je     801020ba <iderw+0x6a>
801020ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020b0:	8d 50 58             	lea    0x58(%eax),%edx
801020b3:	8b 40 58             	mov    0x58(%eax),%eax
801020b6:	85 c0                	test   %eax,%eax
801020b8:	75 f6                	jne    801020b0 <iderw+0x60>
    ;
  *pp = b;
801020ba:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801020bc:	39 1d b4 a5 10 80    	cmp    %ebx,0x8010a5b4
801020c2:	75 14                	jne    801020d8 <iderw+0x88>
801020c4:	eb 2d                	jmp    801020f3 <iderw+0xa3>
801020c6:	66 90                	xchg   %ax,%ax
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
801020c8:	c7 44 24 04 80 a5 10 	movl   $0x8010a580,0x4(%esp)
801020cf:	80 
801020d0:	89 1c 24             	mov    %ebx,(%esp)
801020d3:	e8 28 19 00 00       	call   80103a00 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801020d8:	8b 03                	mov    (%ebx),%eax
801020da:	83 e0 06             	and    $0x6,%eax
801020dd:	83 f8 02             	cmp    $0x2,%eax
801020e0:	75 e6                	jne    801020c8 <iderw+0x78>
    sleep(b, &idelock);
  }

  release(&idelock);
801020e2:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801020e9:	83 c4 14             	add    $0x14,%esp
801020ec:	5b                   	pop    %ebx
801020ed:	5d                   	pop    %ebp
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }

  release(&idelock);
801020ee:	e9 4d 24 00 00       	jmp    80104540 <release>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801020f3:	89 d8                	mov    %ebx,%eax
801020f5:	e8 96 fe ff ff       	call   80101f90 <idestart>
801020fa:	eb dc                	jmp    801020d8 <iderw+0x88>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801020fc:	c7 04 24 92 73 10 80 	movl   $0x80107392,(%esp)
80102103:	e8 c8 e2 ff ff       	call   801003d0 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102108:	c7 04 24 bd 73 10 80 	movl   $0x801073bd,(%esp)
8010210f:	e8 bc e2 ff ff       	call   801003d0 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102114:	c7 04 24 a8 73 10 80 	movl   $0x801073a8,(%esp)
8010211b:	e8 b0 e2 ff ff       	call   801003d0 <panic>

80102120 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	57                   	push   %edi
80102124:	53                   	push   %ebx
80102125:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102128:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
8010212f:	e8 5c 24 00 00       	call   80104590 <acquire>
  if((b = idequeue) == 0){
80102134:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
8010213a:	85 db                	test   %ebx,%ebx
8010213c:	74 2d                	je     8010216b <ideintr+0x4b>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
8010213e:	8b 43 58             	mov    0x58(%ebx),%eax
80102141:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102146:	8b 0b                	mov    (%ebx),%ecx
80102148:	f6 c1 04             	test   $0x4,%cl
8010214b:	74 33                	je     80102180 <ideintr+0x60>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
8010214d:	83 c9 02             	or     $0x2,%ecx
80102150:	83 e1 fb             	and    $0xfffffffb,%ecx
80102153:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102155:	89 1c 24             	mov    %ebx,(%esp)
80102158:	e8 43 17 00 00       	call   801038a0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
8010215d:	a1 b4 a5 10 80       	mov    0x8010a5b4,%eax
80102162:	85 c0                	test   %eax,%eax
80102164:	74 05                	je     8010216b <ideintr+0x4b>
    idestart(idequeue);
80102166:	e8 25 fe ff ff       	call   80101f90 <idestart>

  release(&idelock);
8010216b:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102172:	e8 c9 23 00 00       	call   80104540 <release>
}
80102177:	83 c4 10             	add    $0x10,%esp
8010217a:	5b                   	pop    %ebx
8010217b:	5f                   	pop    %edi
8010217c:	5d                   	pop    %ebp
8010217d:	c3                   	ret    
8010217e:	66 90                	xchg   %ax,%ax
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102180:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102185:	8d 76 00             	lea    0x0(%esi),%esi
80102188:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102189:	0f b6 c0             	movzbl %al,%eax
8010218c:	89 c7                	mov    %eax,%edi
8010218e:	81 e7 c0 00 00 00    	and    $0xc0,%edi
80102194:	83 ff 40             	cmp    $0x40,%edi
80102197:	75 ef                	jne    80102188 <ideintr+0x68>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102199:	a8 21                	test   $0x21,%al
8010219b:	75 b0                	jne    8010214d <ideintr+0x2d>
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010219d:	8d 7b 5c             	lea    0x5c(%ebx),%edi
801021a0:	b9 80 00 00 00       	mov    $0x80,%ecx
801021a5:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021aa:	fc                   	cld    
801021ab:	f3 6d                	rep insl (%dx),%es:(%edi)
801021ad:	8b 0b                	mov    (%ebx),%ecx
801021af:	eb 9c                	jmp    8010214d <ideintr+0x2d>
801021b1:	eb 0d                	jmp    801021c0 <ideinit>
801021b3:	90                   	nop
801021b4:	90                   	nop
801021b5:	90                   	nop
801021b6:	90                   	nop
801021b7:	90                   	nop
801021b8:	90                   	nop
801021b9:	90                   	nop
801021ba:	90                   	nop
801021bb:	90                   	nop
801021bc:	90                   	nop
801021bd:	90                   	nop
801021be:	90                   	nop
801021bf:	90                   	nop

801021c0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
801021c6:	c7 44 24 04 db 73 10 	movl   $0x801073db,0x4(%esp)
801021cd:	80 
801021ce:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
801021d5:	e8 26 22 00 00       	call   80104400 <initlock>
  picenable(IRQ_IDE);
801021da:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801021e1:	e8 da 10 00 00       	call   801032c0 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021e6:	a1 80 2d 11 80       	mov    0x80112d80,%eax
801021eb:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801021f2:	83 e8 01             	sub    $0x1,%eax
801021f5:	89 44 24 04          	mov    %eax,0x4(%esp)
801021f9:	e8 52 00 00 00       	call   80102250 <ioapicenable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021fe:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102203:	90                   	nop
80102204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102208:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102209:	25 c0 00 00 00       	and    $0xc0,%eax
8010220e:	83 f8 40             	cmp    $0x40,%eax
80102211:	75 f5                	jne    80102208 <ideinit+0x48>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102213:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102218:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010221d:	ee                   	out    %al,(%dx)
8010221e:	31 c9                	xor    %ecx,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102220:	b2 f7                	mov    $0xf7,%dl
80102222:	eb 0f                	jmp    80102233 <ideinit+0x73>
80102224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102228:	83 c1 01             	add    $0x1,%ecx
8010222b:	81 f9 e8 03 00 00    	cmp    $0x3e8,%ecx
80102231:	74 0f                	je     80102242 <ideinit+0x82>
80102233:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102234:	84 c0                	test   %al,%al
80102236:	74 f0                	je     80102228 <ideinit+0x68>
      havedisk1 = 1;
80102238:	c7 05 b8 a5 10 80 01 	movl   $0x1,0x8010a5b8
8010223f:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102242:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102247:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010224c:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010224d:	c9                   	leave  
8010224e:	c3                   	ret    
	...

80102250 <ioapicenable>:
}

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
80102250:	8b 15 84 27 11 80    	mov    0x80112784,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102256:	55                   	push   %ebp
80102257:	89 e5                	mov    %esp,%ebp
80102259:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
8010225c:	85 d2                	test   %edx,%edx
8010225e:	74 31                	je     80102291 <ioapicenable+0x41>
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102260:	8b 15 54 26 11 80    	mov    0x80112654,%edx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102266:	8d 48 20             	lea    0x20(%eax),%ecx
80102269:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010226d:	89 02                	mov    %eax,(%edx)
  ioapic->data = data;
8010226f:	8b 15 54 26 11 80    	mov    0x80112654,%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102275:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102278:	89 4a 10             	mov    %ecx,0x10(%edx)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010227b:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102281:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102284:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102286:	a1 54 26 11 80       	mov    0x80112654,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010228b:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010228e:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102291:	5d                   	pop    %ebp
80102292:	c3                   	ret    
80102293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022a0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022a0:	55                   	push   %ebp
801022a1:	89 e5                	mov    %esp,%ebp
801022a3:	56                   	push   %esi
801022a4:	53                   	push   %ebx
801022a5:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  if(!ismp)
801022a8:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
801022ae:	85 c9                	test   %ecx,%ecx
801022b0:	0f 84 9e 00 00 00    	je     80102354 <ioapicinit+0xb4>
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801022b6:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801022bd:	00 00 00 
  return ioapic->data;
801022c0:	8b 35 10 00 c0 fe    	mov    0xfec00010,%esi
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801022c6:	bb 00 00 c0 fe       	mov    $0xfec00000,%ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801022cb:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
801022d2:	00 00 00 
  return ioapic->data;
801022d5:	a1 10 00 c0 fe       	mov    0xfec00010,%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801022da:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022e1:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
801022e8:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801022eb:	c1 ee 10             	shr    $0x10,%esi
  id = ioapicread(REG_ID) >> 24;
801022ee:	c1 e8 18             	shr    $0x18,%eax

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801022f1:	81 e6 ff 00 00 00    	and    $0xff,%esi
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801022f7:	39 c2                	cmp    %eax,%edx
801022f9:	74 12                	je     8010230d <ioapicinit+0x6d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801022fb:	c7 04 24 e0 73 10 80 	movl   $0x801073e0,(%esp)
80102302:	e8 69 e5 ff ff       	call   80100870 <cprintf>
80102307:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
8010230d:	ba 10 00 00 00       	mov    $0x10,%edx
80102312:	31 c0                	xor    %eax,%eax
80102314:	eb 08                	jmp    8010231e <ioapicinit+0x7e>
80102316:	66 90                	xchg   %ax,%ax

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102318:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010231e:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
80102320:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102326:	8d 48 20             	lea    0x20(%eax),%ecx
80102329:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010232f:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102332:	89 4b 10             	mov    %ecx,0x10(%ebx)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102335:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
8010233b:	8d 5a 01             	lea    0x1(%edx),%ebx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010233e:	83 c2 02             	add    $0x2,%edx
80102341:	39 c6                	cmp    %eax,%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102343:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102345:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
8010234b:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102352:	7d c4                	jge    80102318 <ioapicinit+0x78>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102354:	83 c4 10             	add    $0x10,%esp
80102357:	5b                   	pop    %ebx
80102358:	5e                   	pop    %esi
80102359:	5d                   	pop    %ebp
8010235a:	c3                   	ret    
8010235b:	00 00                	add    %al,(%eax)
8010235d:	00 00                	add    %al,(%eax)
	...

80102360 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102360:	55                   	push   %ebp
80102361:	89 e5                	mov    %esp,%ebp
80102363:	53                   	push   %ebx
80102364:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
80102367:	8b 15 94 26 11 80    	mov    0x80112694,%edx
8010236d:	85 d2                	test   %edx,%edx
8010236f:	75 2f                	jne    801023a0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102371:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102377:	85 db                	test   %ebx,%ebx
80102379:	74 07                	je     80102382 <kalloc+0x22>
    kmem.freelist = r->next;
8010237b:	8b 03                	mov    (%ebx),%eax
8010237d:	a3 98 26 11 80       	mov    %eax,0x80112698
  if(kmem.use_lock)
80102382:	a1 94 26 11 80       	mov    0x80112694,%eax
80102387:	85 c0                	test   %eax,%eax
80102389:	74 0c                	je     80102397 <kalloc+0x37>
    release(&kmem.lock);
8010238b:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
80102392:	e8 a9 21 00 00       	call   80104540 <release>
  return (char*)r;
}
80102397:	89 d8                	mov    %ebx,%eax
80102399:	83 c4 14             	add    $0x14,%esp
8010239c:	5b                   	pop    %ebx
8010239d:	5d                   	pop    %ebp
8010239e:	c3                   	ret    
8010239f:	90                   	nop
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801023a0:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
801023a7:	e8 e4 21 00 00       	call   80104590 <acquire>
801023ac:	eb c3                	jmp    80102371 <kalloc+0x11>
801023ae:	66 90                	xchg   %ax,%ax

801023b0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	53                   	push   %ebx
801023b4:	83 ec 14             	sub    $0x14,%esp
801023b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023ba:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023c0:	75 7c                	jne    8010243e <kfree+0x8e>
801023c2:	81 fb 28 57 11 80    	cmp    $0x80115728,%ebx
801023c8:	72 74                	jb     8010243e <kfree+0x8e>
801023ca:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801023d0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801023d5:	77 67                	ja     8010243e <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801023d7:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801023de:	00 
801023df:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801023e6:	00 
801023e7:	89 1c 24             	mov    %ebx,(%esp)
801023ea:	e8 41 22 00 00       	call   80104630 <memset>

  if(kmem.use_lock)
801023ef:	a1 94 26 11 80       	mov    0x80112694,%eax
801023f4:	85 c0                	test   %eax,%eax
801023f6:	75 38                	jne    80102430 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801023f8:	a1 98 26 11 80       	mov    0x80112698,%eax
801023fd:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801023ff:	8b 0d 94 26 11 80    	mov    0x80112694,%ecx

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102405:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
8010240b:	85 c9                	test   %ecx,%ecx
8010240d:	75 09                	jne    80102418 <kfree+0x68>
    release(&kmem.lock);
}
8010240f:	83 c4 14             	add    $0x14,%esp
80102412:	5b                   	pop    %ebx
80102413:	5d                   	pop    %ebp
80102414:	c3                   	ret    
80102415:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102418:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
8010241f:	83 c4 14             	add    $0x14,%esp
80102422:	5b                   	pop    %ebx
80102423:	5d                   	pop    %ebp
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102424:	e9 17 21 00 00       	jmp    80104540 <release>
80102429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102430:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
80102437:	e8 54 21 00 00       	call   80104590 <acquire>
8010243c:	eb ba                	jmp    801023f8 <kfree+0x48>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
8010243e:	c7 04 24 12 74 10 80 	movl   $0x80107412,(%esp)
80102445:	e8 86 df ff ff       	call   801003d0 <panic>
8010244a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102450 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	56                   	push   %esi
80102454:	53                   	push   %ebx
80102455:	83 ec 10             	sub    $0x10,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102458:	8b 55 08             	mov    0x8(%ebp),%edx
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
8010245b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010245e:	81 c2 ff 0f 00 00    	add    $0xfff,%edx
80102464:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010246a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80102470:	39 f3                	cmp    %esi,%ebx
80102472:	76 08                	jbe    8010247c <freerange+0x2c>
80102474:	eb 18                	jmp    8010248e <freerange+0x3e>
80102476:	66 90                	xchg   %ax,%ax
80102478:	89 da                	mov    %ebx,%edx
8010247a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010247c:	89 14 24             	mov    %edx,(%esp)
8010247f:	e8 2c ff ff ff       	call   801023b0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102484:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010248a:	39 f0                	cmp    %esi,%eax
8010248c:	76 ea                	jbe    80102478 <freerange+0x28>
    kfree(p);
}
8010248e:	83 c4 10             	add    $0x10,%esp
80102491:	5b                   	pop    %ebx
80102492:	5e                   	pop    %esi
80102493:	5d                   	pop    %ebp
80102494:	c3                   	ret    
80102495:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024a0 <kinit2>:
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
801024a6:	8b 45 0c             	mov    0xc(%ebp),%eax
801024a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801024ad:	8b 45 08             	mov    0x8(%ebp),%eax
801024b0:	89 04 24             	mov    %eax,(%esp)
801024b3:	e8 98 ff ff ff       	call   80102450 <freerange>
  kmem.use_lock = 1;
801024b8:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801024bf:	00 00 00 
}
801024c2:	c9                   	leave  
801024c3:	c3                   	ret    
801024c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801024d0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	83 ec 18             	sub    $0x18,%esp
801024d6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801024d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801024dc:	89 75 fc             	mov    %esi,-0x4(%ebp)
801024df:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024e2:	c7 44 24 04 18 74 10 	movl   $0x80107418,0x4(%esp)
801024e9:	80 
801024ea:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
801024f1:	e8 0a 1f 00 00       	call   80104400 <initlock>
  kmem.use_lock = 0;
  freerange(vstart, vend);
801024f6:	89 75 0c             	mov    %esi,0xc(%ebp)
}
801024f9:	8b 75 fc             	mov    -0x4(%ebp),%esi
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
801024fc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801024ff:	8b 5d f8             	mov    -0x8(%ebp),%ebx
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102502:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102509:	00 00 00 
  freerange(vstart, vend);
}
8010250c:	89 ec                	mov    %ebp,%esp
8010250e:	5d                   	pop    %ebp
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
8010250f:	e9 3c ff ff ff       	jmp    80102450 <freerange>
	...

80102520 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102520:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102521:	ba 64 00 00 00       	mov    $0x64,%edx
80102526:	89 e5                	mov    %esp,%ebp
80102528:	ec                   	in     (%dx),%al
80102529:	89 c2                	mov    %eax,%edx
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
8010252b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102530:	83 e2 01             	and    $0x1,%edx
80102533:	74 41                	je     80102576 <kbdgetc+0x56>
80102535:	ba 60 00 00 00       	mov    $0x60,%edx
8010253a:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
8010253b:	0f b6 c0             	movzbl %al,%eax

  if(data == 0xE0){
8010253e:	3d e0 00 00 00       	cmp    $0xe0,%eax
80102543:	0f 84 7f 00 00 00    	je     801025c8 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102549:	84 c0                	test   %al,%al
8010254b:	79 2b                	jns    80102578 <kbdgetc+0x58>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010254d:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80102553:	89 c1                	mov    %eax,%ecx
80102555:	83 e1 7f             	and    $0x7f,%ecx
80102558:	f6 c2 40             	test   $0x40,%dl
8010255b:	0f 44 c1             	cmove  %ecx,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010255e:	0f b6 80 20 74 10 80 	movzbl -0x7fef8be0(%eax),%eax
80102565:	83 c8 40             	or     $0x40,%eax
80102568:	0f b6 c0             	movzbl %al,%eax
8010256b:	f7 d0                	not    %eax
8010256d:	21 d0                	and    %edx,%eax
8010256f:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
80102574:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102576:	5d                   	pop    %ebp
80102577:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102578:	8b 0d bc a5 10 80    	mov    0x8010a5bc,%ecx
8010257e:	f6 c1 40             	test   $0x40,%cl
80102581:	74 05                	je     80102588 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102583:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
80102585:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102588:	0f b6 90 20 74 10 80 	movzbl -0x7fef8be0(%eax),%edx
8010258f:	09 ca                	or     %ecx,%edx
80102591:	0f b6 88 20 75 10 80 	movzbl -0x7fef8ae0(%eax),%ecx
80102598:	31 ca                	xor    %ecx,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010259a:	89 d1                	mov    %edx,%ecx
8010259c:	83 e1 03             	and    $0x3,%ecx
8010259f:	8b 0c 8d 20 76 10 80 	mov    -0x7fef89e0(,%ecx,4),%ecx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801025a6:	89 15 bc a5 10 80    	mov    %edx,0x8010a5bc
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
801025ac:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
801025af:	0f b6 04 01          	movzbl (%ecx,%eax,1),%eax
  if(shift & CAPSLOCK){
801025b3:	74 c1                	je     80102576 <kbdgetc+0x56>
    if('a' <= c && c <= 'z')
801025b5:	8d 50 9f             	lea    -0x61(%eax),%edx
801025b8:	83 fa 19             	cmp    $0x19,%edx
801025bb:	77 1b                	ja     801025d8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025bd:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025c0:	5d                   	pop    %ebp
801025c1:	c3                   	ret    
801025c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801025c8:	30 c0                	xor    %al,%al
801025ca:	83 0d bc a5 10 80 40 	orl    $0x40,0x8010a5bc
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025d1:	5d                   	pop    %ebp
801025d2:	c3                   	ret    
801025d3:	90                   	nop
801025d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801025d8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025db:	8d 50 20             	lea    0x20(%eax),%edx
801025de:	83 f9 19             	cmp    $0x19,%ecx
801025e1:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801025e4:	5d                   	pop    %ebp
801025e5:	c3                   	ret    
801025e6:	8d 76 00             	lea    0x0(%esi),%esi
801025e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025f0 <kbdintr>:

void
kbdintr(void)
{
801025f0:	55                   	push   %ebp
801025f1:	89 e5                	mov    %esp,%ebp
801025f3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801025f6:	c7 04 24 20 25 10 80 	movl   $0x80102520,(%esp)
801025fd:	e8 3e e0 ff ff       	call   80100640 <consoleintr>
}
80102602:	c9                   	leave  
80102603:	c3                   	ret    
	...

80102610 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
80102610:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}
//PAGEBREAK!

void
lapicinit(void)
{
80102615:	55                   	push   %ebp
80102616:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102618:	85 c0                	test   %eax,%eax
8010261a:	0f 84 09 01 00 00    	je     80102729 <lapicinit+0x119>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102620:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102627:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010262a:	a1 9c 26 11 80       	mov    0x8011269c,%eax
8010262f:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102632:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102639:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010263c:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102641:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102644:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010264b:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
8010264e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102653:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102656:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010265d:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102660:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102665:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102668:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010266f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102672:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102677:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010267a:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102681:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102684:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102689:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010268c:	8b 50 30             	mov    0x30(%eax),%edx
8010268f:	c1 ea 10             	shr    $0x10,%edx
80102692:	80 fa 03             	cmp    $0x3,%dl
80102695:	0f 87 95 00 00 00    	ja     80102730 <lapicinit+0x120>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010269b:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026a2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026a5:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801026aa:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ad:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026b4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b7:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801026bc:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026bf:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026c6:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c9:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801026ce:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026d1:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026d8:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026db:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801026e0:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026e3:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026ea:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ed:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801026f2:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026f5:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026fc:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026ff:	8b 0d 9c 26 11 80    	mov    0x8011269c,%ecx
80102705:	8b 41 20             	mov    0x20(%ecx),%eax
80102708:	8d 91 00 03 00 00    	lea    0x300(%ecx),%edx
8010270e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102710:	8b 02                	mov    (%edx),%eax
80102712:	f6 c4 10             	test   $0x10,%ah
80102715:	75 f9                	jne    80102710 <lapicinit+0x100>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102717:	c7 81 80 00 00 00 00 	movl   $0x0,0x80(%ecx)
8010271e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102721:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102726:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102729:	5d                   	pop    %ebp
8010272a:	c3                   	ret    
8010272b:	90                   	nop
8010272c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102730:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102737:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010273a:	a1 9c 26 11 80       	mov    0x8011269c,%eax
8010273f:	8b 50 20             	mov    0x20(%eax),%edx
80102742:	e9 54 ff ff ff       	jmp    8010269b <lapicinit+0x8b>
80102747:	89 f6                	mov    %esi,%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102750:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102755:	55                   	push   %ebp
80102756:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102758:	85 c0                	test   %eax,%eax
8010275a:	74 12                	je     8010276e <lapiceoi+0x1e>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010275c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102763:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102766:	a1 9c 26 11 80       	mov    0x8011269c,%eax
8010276b:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
8010276e:	5d                   	pop    %ebp
8010276f:	c3                   	ret    

80102770 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102770:	55                   	push   %ebp
80102771:	89 e5                	mov    %esp,%ebp
}
80102773:	5d                   	pop    %ebp
80102774:	c3                   	ret    
80102775:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102780 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102780:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102781:	ba 70 00 00 00       	mov    $0x70,%edx
80102786:	89 e5                	mov    %esp,%ebp
80102788:	b8 0f 00 00 00       	mov    $0xf,%eax
8010278d:	53                   	push   %ebx
8010278e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102791:	0f b6 5d 08          	movzbl 0x8(%ebp),%ebx
80102795:	ee                   	out    %al,(%dx)
80102796:	b8 0a 00 00 00       	mov    $0xa,%eax
8010279b:	b2 71                	mov    $0x71,%dl
8010279d:	ee                   	out    %al,(%dx)
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
8010279e:	89 c8                	mov    %ecx,%eax
801027a0:	c1 e8 04             	shr    $0x4,%eax
801027a3:	66 a3 69 04 00 80    	mov    %ax,0x80000469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a9:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027ae:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027b1:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
801027b8:	00 00 

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
801027ba:	c1 e9 0c             	shr    $0xc,%ecx
801027bd:	80 cd 06             	or     $0x6,%ch
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027c0:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027c6:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027cb:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ce:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027d5:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d8:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027dd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027e0:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027e7:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027ea:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027ef:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027f2:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f8:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027fd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102800:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102806:	a1 9c 26 11 80       	mov    0x8011269c,%eax
8010280b:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010280e:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102814:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102819:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010281c:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102822:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102827:	5b                   	pop    %ebx
80102828:	5d                   	pop    %ebp

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
80102829:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010282c:	c3                   	ret    
8010282d:	8d 76 00             	lea    0x0(%esi),%esi

80102830 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102830:	55                   	push   %ebp
80102831:	ba 70 00 00 00       	mov    $0x70,%edx
80102836:	89 e5                	mov    %esp,%ebp
80102838:	b8 0b 00 00 00       	mov    $0xb,%eax
8010283d:	57                   	push   %edi
8010283e:	56                   	push   %esi
8010283f:	53                   	push   %ebx
80102840:	83 ec 6c             	sub    $0x6c,%esp
80102843:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102844:	b2 71                	mov    $0x71,%dl
80102846:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102847:	bb 70 00 00 00       	mov    $0x70,%ebx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010284c:	88 45 a7             	mov    %al,-0x59(%ebp)
8010284f:	90                   	nop
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102850:	31 c0                	xor    %eax,%eax
80102852:	89 da                	mov    %ebx,%edx
80102854:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102855:	b9 71 00 00 00       	mov    $0x71,%ecx
8010285a:	89 ca                	mov    %ecx,%edx
8010285c:	ec                   	in     (%dx),%al
static uint cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
8010285d:	0f b6 f0             	movzbl %al,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102860:	89 da                	mov    %ebx,%edx
80102862:	b8 02 00 00 00       	mov    $0x2,%eax
80102867:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102868:	89 ca                	mov    %ecx,%edx
8010286a:	ec                   	in     (%dx),%al
8010286b:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010286e:	89 da                	mov    %ebx,%edx
80102870:	89 45 a8             	mov    %eax,-0x58(%ebp)
80102873:	b8 04 00 00 00       	mov    $0x4,%eax
80102878:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102879:	89 ca                	mov    %ecx,%edx
8010287b:	ec                   	in     (%dx),%al
8010287c:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010287f:	89 da                	mov    %ebx,%edx
80102881:	89 45 ac             	mov    %eax,-0x54(%ebp)
80102884:	b8 07 00 00 00       	mov    $0x7,%eax
80102889:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288a:	89 ca                	mov    %ecx,%edx
8010288c:	ec                   	in     (%dx),%al
8010288d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102890:	89 da                	mov    %ebx,%edx
80102892:	89 45 b0             	mov    %eax,-0x50(%ebp)
80102895:	b8 08 00 00 00       	mov    $0x8,%eax
8010289a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289b:	89 ca                	mov    %ecx,%edx
8010289d:	ec                   	in     (%dx),%al
8010289e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a1:	89 da                	mov    %ebx,%edx
801028a3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801028a6:	b8 09 00 00 00       	mov    $0x9,%eax
801028ab:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ac:	89 ca                	mov    %ecx,%edx
801028ae:	ec                   	in     (%dx),%al
801028af:	0f b6 f8             	movzbl %al,%edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b2:	89 da                	mov    %ebx,%edx
801028b4:	b8 0a 00 00 00       	mov    $0xa,%eax
801028b9:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ba:	89 ca                	mov    %ecx,%edx
801028bc:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028bd:	84 c0                	test   %al,%al
801028bf:	78 8f                	js     80102850 <cmostime+0x20>
801028c1:	8b 45 a8             	mov    -0x58(%ebp),%eax
801028c4:	8b 55 ac             	mov    -0x54(%ebp),%edx
801028c7:	89 75 d0             	mov    %esi,-0x30(%ebp)
801028ca:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801028cd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028d0:	8b 45 b0             	mov    -0x50(%ebp),%eax
801028d3:	89 55 d8             	mov    %edx,-0x28(%ebp)
801028d6:	8b 55 b4             	mov    -0x4c(%ebp),%edx
801028d9:	89 45 dc             	mov    %eax,-0x24(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028dc:	31 c0                	xor    %eax,%eax
801028de:	89 55 e0             	mov    %edx,-0x20(%ebp)
801028e1:	89 da                	mov    %ebx,%edx
801028e3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e4:	89 ca                	mov    %ecx,%edx
801028e6:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801028e7:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ea:	89 da                	mov    %ebx,%edx
801028ec:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028ef:	b8 02 00 00 00       	mov    $0x2,%eax
801028f4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f5:	89 ca                	mov    %ecx,%edx
801028f7:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801028f8:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028fb:	89 da                	mov    %ebx,%edx
801028fd:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102900:	b8 04 00 00 00       	mov    $0x4,%eax
80102905:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102906:	89 ca                	mov    %ecx,%edx
80102908:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102909:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010290c:	89 da                	mov    %ebx,%edx
8010290e:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102911:	b8 07 00 00 00       	mov    $0x7,%eax
80102916:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102917:	89 ca                	mov    %ecx,%edx
80102919:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
8010291a:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010291d:	89 da                	mov    %ebx,%edx
8010291f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102922:	b8 08 00 00 00       	mov    $0x8,%eax
80102927:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102928:	89 ca                	mov    %ecx,%edx
8010292a:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
8010292b:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010292e:	89 da                	mov    %ebx,%edx
80102930:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102933:	b8 09 00 00 00       	mov    $0x9,%eax
80102938:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102939:	89 ca                	mov    %ecx,%edx
8010293b:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
8010293c:	0f b6 c8             	movzbl %al,%ecx
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010293f:	8d 55 d0             	lea    -0x30(%ebp),%edx
80102942:	8d 45 b8             	lea    -0x48(%ebp),%eax
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
80102945:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102948:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
8010294f:	00 
80102950:	89 44 24 04          	mov    %eax,0x4(%esp)
80102954:	89 14 24             	mov    %edx,(%esp)
80102957:	e8 44 1d 00 00       	call   801046a0 <memcmp>
8010295c:	85 c0                	test   %eax,%eax
8010295e:	0f 85 ec fe ff ff    	jne    80102850 <cmostime+0x20>
      break;
  }

  // convert
  if(bcd) {
80102964:	f6 45 a7 04          	testb  $0x4,-0x59(%ebp)
80102968:	75 78                	jne    801029e2 <cmostime+0x1b2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010296a:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010296d:	89 c2                	mov    %eax,%edx
8010296f:	83 e0 0f             	and    $0xf,%eax
80102972:	c1 ea 04             	shr    $0x4,%edx
80102975:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102978:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297b:	89 45 d0             	mov    %eax,-0x30(%ebp)
    CONV(minute);
8010297e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80102981:	89 c2                	mov    %eax,%edx
80102983:	83 e0 0f             	and    $0xf,%eax
80102986:	c1 ea 04             	shr    $0x4,%edx
80102989:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010298f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    CONV(hour  );
80102992:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102995:	89 c2                	mov    %eax,%edx
80102997:	83 e0 0f             	and    $0xf,%eax
8010299a:	c1 ea 04             	shr    $0x4,%edx
8010299d:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a0:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029a3:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(day   );
801029a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801029a9:	89 c2                	mov    %eax,%edx
801029ab:	83 e0 0f             	and    $0xf,%eax
801029ae:	c1 ea 04             	shr    $0x4,%edx
801029b1:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029b4:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029b7:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(month );
801029ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
801029bd:	89 c2                	mov    %eax,%edx
801029bf:	83 e0 0f             	and    $0xf,%eax
801029c2:	c1 ea 04             	shr    $0x4,%edx
801029c5:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029c8:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(year  );
801029ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801029d1:	89 c2                	mov    %eax,%edx
801029d3:	83 e0 0f             	and    $0xf,%eax
801029d6:	c1 ea 04             	shr    $0x4,%edx
801029d9:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029dc:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
#undef     CONV
  }

  *r = t1;
801029e2:	8b 45 d0             	mov    -0x30(%ebp),%eax
801029e5:	8b 55 08             	mov    0x8(%ebp),%edx
801029e8:	89 02                	mov    %eax,(%edx)
801029ea:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801029ed:	89 42 04             	mov    %eax,0x4(%edx)
801029f0:	8b 45 d8             	mov    -0x28(%ebp),%eax
801029f3:	89 42 08             	mov    %eax,0x8(%edx)
801029f6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801029f9:	89 42 0c             	mov    %eax,0xc(%edx)
801029fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801029ff:	89 42 10             	mov    %eax,0x10(%edx)
80102a02:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102a05:	89 42 14             	mov    %eax,0x14(%edx)
  r->year += 2000;
80102a08:	81 42 14 d0 07 00 00 	addl   $0x7d0,0x14(%edx)
}
80102a0f:	83 c4 6c             	add    $0x6c,%esp
80102a12:	5b                   	pop    %ebx
80102a13:	5e                   	pop    %esi
80102a14:	5f                   	pop    %edi
80102a15:	5d                   	pop    %ebp
80102a16:	c3                   	ret    
80102a17:	89 f6                	mov    %esi,%esi
80102a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a20 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
80102a20:	55                   	push   %ebp
80102a21:	89 e5                	mov    %esp,%ebp
80102a23:	56                   	push   %esi
80102a24:	53                   	push   %ebx
80102a25:	83 ec 10             	sub    $0x10,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102a28:	9c                   	pushf  
80102a29:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102a2a:	f6 c4 02             	test   $0x2,%ah
80102a2d:	74 12                	je     80102a41 <cpunum+0x21>
    static int n;
    if(n++ == 0)
80102a2f:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
80102a34:	8d 50 01             	lea    0x1(%eax),%edx
80102a37:	85 c0                	test   %eax,%eax
80102a39:	89 15 c0 a5 10 80    	mov    %edx,0x8010a5c0
80102a3f:	74 4a                	je     80102a8b <cpunum+0x6b>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
80102a41:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102a46:	85 c0                	test   %eax,%eax
80102a48:	74 5d                	je     80102aa7 <cpunum+0x87>
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
80102a4a:	8b 35 80 2d 11 80    	mov    0x80112d80,%esi
  }

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
80102a50:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
80102a53:	85 f6                	test   %esi,%esi
80102a55:	7e 59                	jle    80102ab0 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
80102a57:	0f b6 0d a0 27 11 80 	movzbl 0x801127a0,%ecx
  }

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
80102a5e:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
80102a61:	31 c0                	xor    %eax,%eax
80102a63:	ba 5c 28 11 80       	mov    $0x8011285c,%edx
80102a68:	39 d9                	cmp    %ebx,%ecx
80102a6a:	74 3b                	je     80102aa7 <cpunum+0x87>
80102a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
80102a70:	83 c0 01             	add    $0x1,%eax
80102a73:	39 f0                	cmp    %esi,%eax
80102a75:	7d 39                	jge    80102ab0 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
80102a77:	0f b6 0a             	movzbl (%edx),%ecx
80102a7a:	81 c2 bc 00 00 00    	add    $0xbc,%edx
80102a80:	39 d9                	cmp    %ebx,%ecx
80102a82:	75 ec                	jne    80102a70 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
80102a84:	83 c4 10             	add    $0x10,%esp
80102a87:	5b                   	pop    %ebx
80102a88:	5e                   	pop    %esi
80102a89:	5d                   	pop    %ebp
80102a8a:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
80102a8b:	8b 45 04             	mov    0x4(%ebp),%eax
80102a8e:	c7 04 24 30 76 10 80 	movl   $0x80107630,(%esp)
80102a95:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a99:	e8 d2 dd ff ff       	call   80100870 <cprintf>
        __builtin_return_address(0));
  }

  if (!lapic)
80102a9e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102aa3:	85 c0                	test   %eax,%eax
80102aa5:	75 a3                	jne    80102a4a <cpunum+0x2a>
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
80102aa7:	83 c4 10             	add    $0x10,%esp
  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
80102aaa:	31 c0                	xor    %eax,%eax
}
80102aac:	5b                   	pop    %ebx
80102aad:	5e                   	pop    %esi
80102aae:	5d                   	pop    %ebp
80102aaf:	c3                   	ret    
  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
80102ab0:	c7 04 24 5c 76 10 80 	movl   $0x8010765c,(%esp)
80102ab7:	e8 14 d9 ff ff       	call   801003d0 <panic>
80102abc:	00 00                	add    %al,(%eax)
	...

80102ac0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	53                   	push   %ebx
80102ac4:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ac7:	a1 e8 26 11 80       	mov    0x801126e8,%eax
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102acc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102acf:	83 f8 1d             	cmp    $0x1d,%eax
80102ad2:	7f 7e                	jg     80102b52 <log_write+0x92>
80102ad4:	8b 15 d8 26 11 80    	mov    0x801126d8,%edx
80102ada:	83 ea 01             	sub    $0x1,%edx
80102add:	39 d0                	cmp    %edx,%eax
80102adf:	7d 71                	jge    80102b52 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102ae1:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102ae6:	85 c0                	test   %eax,%eax
80102ae8:	7e 74                	jle    80102b5e <log_write+0x9e>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102aea:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102af1:	e8 9a 1a 00 00       	call   80104590 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102af6:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102afc:	85 c9                	test   %ecx,%ecx
80102afe:	7e 4b                	jle    80102b4b <log_write+0x8b>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102b00:	8b 53 08             	mov    0x8(%ebx),%edx
80102b03:	31 c0                	xor    %eax,%eax
80102b05:	39 15 ec 26 11 80    	cmp    %edx,0x801126ec
80102b0b:	75 0c                	jne    80102b19 <log_write+0x59>
80102b0d:	eb 11                	jmp    80102b20 <log_write+0x60>
80102b0f:	90                   	nop
80102b10:	3b 14 85 ec 26 11 80 	cmp    -0x7feed914(,%eax,4),%edx
80102b17:	74 07                	je     80102b20 <log_write+0x60>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102b19:	83 c0 01             	add    $0x1,%eax
80102b1c:	39 c8                	cmp    %ecx,%eax
80102b1e:	7c f0                	jl     80102b10 <log_write+0x50>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102b20:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
80102b27:	39 05 e8 26 11 80    	cmp    %eax,0x801126e8
80102b2d:	75 08                	jne    80102b37 <log_write+0x77>
    log.lh.n++;
80102b2f:	83 c0 01             	add    $0x1,%eax
80102b32:	a3 e8 26 11 80       	mov    %eax,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102b37:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102b3a:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102b41:	83 c4 14             	add    $0x14,%esp
80102b44:	5b                   	pop    %ebx
80102b45:	5d                   	pop    %ebp
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102b46:	e9 f5 19 00 00       	jmp    80104540 <release>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102b4b:	8b 53 08             	mov    0x8(%ebx),%edx
80102b4e:	31 c0                	xor    %eax,%eax
80102b50:	eb ce                	jmp    80102b20 <log_write+0x60>
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102b52:	c7 04 24 6c 76 10 80 	movl   $0x8010766c,(%esp)
80102b59:	e8 72 d8 ff ff       	call   801003d0 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102b5e:	c7 04 24 82 76 10 80 	movl   $0x80107682,(%esp)
80102b65:	e8 66 d8 ff ff       	call   801003d0 <panic>
80102b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b70 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	57                   	push   %edi
80102b74:	56                   	push   %esi
80102b75:	53                   	push   %ebx
80102b76:	83 ec 1c             	sub    $0x1c,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b79:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102b7f:	85 d2                	test   %edx,%edx
80102b81:	7e 78                	jle    80102bfb <install_trans+0x8b>
80102b83:	31 db                	xor    %ebx,%ebx
80102b85:	8d 76 00             	lea    0x0(%esi),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b88:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102b8d:	8d 44 03 01          	lea    0x1(%ebx,%eax,1),%eax
80102b91:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b95:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102b9a:	89 04 24             	mov    %eax,(%esp)
80102b9d:	e8 6e d5 ff ff       	call   80100110 <bread>
80102ba2:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102ba4:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bab:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bae:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bb2:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102bb7:	89 04 24             	mov    %eax,(%esp)
80102bba:	e8 51 d5 ff ff       	call   80100110 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bbf:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102bc6:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bc7:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bc9:	8d 47 5c             	lea    0x5c(%edi),%eax
80102bcc:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bd0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bd3:	89 04 24             	mov    %eax,(%esp)
80102bd6:	e8 25 1b 00 00       	call   80104700 <memmove>
    bwrite(dbuf);  // write dst to disk
80102bdb:	89 34 24             	mov    %esi,(%esp)
80102bde:	e8 ed d4 ff ff       	call   801000d0 <bwrite>
    brelse(lbuf);
80102be3:	89 3c 24             	mov    %edi,(%esp)
80102be6:	e8 55 d4 ff ff       	call   80100040 <brelse>
    brelse(dbuf);
80102beb:	89 34 24             	mov    %esi,(%esp)
80102bee:	e8 4d d4 ff ff       	call   80100040 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bf3:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102bf9:	7f 8d                	jg     80102b88 <install_trans+0x18>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102bfb:	83 c4 1c             	add    $0x1c,%esp
80102bfe:	5b                   	pop    %ebx
80102bff:	5e                   	pop    %esi
80102c00:	5f                   	pop    %edi
80102c01:	5d                   	pop    %ebp
80102c02:	c3                   	ret    
80102c03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	56                   	push   %esi
80102c14:	53                   	push   %ebx
80102c15:	83 ec 10             	sub    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c18:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102c1d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c21:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102c26:	89 04 24             	mov    %eax,(%esp)
80102c29:	e8 e2 d4 ff ff       	call   80100110 <bread>
80102c2e:	89 c6                	mov    %eax,%esi
  struct logheader *hb = (struct logheader *) (buf->data);
80102c30:	8d 58 5c             	lea    0x5c(%eax),%ebx
  int i;
  hb->n = log.lh.n;
80102c33:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c38:	89 46 5c             	mov    %eax,0x5c(%esi)
  for (i = 0; i < log.lh.n; i++) {
80102c3b:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102c41:	85 c9                	test   %ecx,%ecx
80102c43:	7e 19                	jle    80102c5e <write_head+0x4e>
80102c45:	31 d2                	xor    %edx,%edx
80102c47:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102c48:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102c4f:	89 4c 93 04          	mov    %ecx,0x4(%ebx,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c53:	83 c2 01             	add    $0x1,%edx
80102c56:	39 15 e8 26 11 80    	cmp    %edx,0x801126e8
80102c5c:	7f ea                	jg     80102c48 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102c5e:	89 34 24             	mov    %esi,(%esp)
80102c61:	e8 6a d4 ff ff       	call   801000d0 <bwrite>
  brelse(buf);
80102c66:	89 34 24             	mov    %esi,(%esp)
80102c69:	e8 d2 d3 ff ff       	call   80100040 <brelse>
}
80102c6e:	83 c4 10             	add    $0x10,%esp
80102c71:	5b                   	pop    %ebx
80102c72:	5e                   	pop    %esi
80102c73:	5d                   	pop    %ebp
80102c74:	c3                   	ret    
80102c75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c80:	55                   	push   %ebp
80102c81:	89 e5                	mov    %esp,%ebp
80102c83:	57                   	push   %edi
80102c84:	56                   	push   %esi
80102c85:	53                   	push   %ebx
80102c86:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c89:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102c90:	e8 fb 18 00 00       	call   80104590 <acquire>
  log.outstanding -= 1;
80102c95:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102c9a:	8b 3d e0 26 11 80    	mov    0x801126e0,%edi
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102ca0:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102ca3:	85 ff                	test   %edi,%edi
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102ca5:	a3 dc 26 11 80       	mov    %eax,0x801126dc
  if(log.committing)
80102caa:	0f 85 f2 00 00 00    	jne    80102da2 <end_op+0x122>
    panic("log.committing");
  if(log.outstanding == 0){
80102cb0:	85 c0                	test   %eax,%eax
80102cb2:	0f 85 ca 00 00 00    	jne    80102d82 <end_op+0x102>
    do_commit = 1;
    log.committing = 1;
80102cb8:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102cbf:	00 00 00 
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102cc2:	31 db                	xor    %ebx,%ebx
80102cc4:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102ccb:	e8 70 18 00 00       	call   80104540 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102cd0:	8b 35 e8 26 11 80    	mov    0x801126e8,%esi
80102cd6:	85 f6                	test   %esi,%esi
80102cd8:	0f 8e 8e 00 00 00    	jle    80102d6c <end_op+0xec>
80102cde:	66 90                	xchg   %ax,%ax
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102ce0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102ce5:	8d 44 03 01          	lea    0x1(%ebx,%eax,1),%eax
80102ce9:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ced:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102cf2:	89 04 24             	mov    %eax,(%esp)
80102cf5:	e8 16 d4 ff ff       	call   80100110 <bread>
80102cfa:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cfc:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d03:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d06:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d0a:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102d0f:	89 04 24             	mov    %eax,(%esp)
80102d12:	e8 f9 d3 ff ff       	call   80100110 <bread>
    memmove(to->data, from->data, BSIZE);
80102d17:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102d1e:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d1f:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d21:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d24:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d28:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d2b:	89 04 24             	mov    %eax,(%esp)
80102d2e:	e8 cd 19 00 00       	call   80104700 <memmove>
    bwrite(to);  // write the log
80102d33:	89 34 24             	mov    %esi,(%esp)
80102d36:	e8 95 d3 ff ff       	call   801000d0 <bwrite>
    brelse(from);
80102d3b:	89 3c 24             	mov    %edi,(%esp)
80102d3e:	e8 fd d2 ff ff       	call   80100040 <brelse>
    brelse(to);
80102d43:	89 34 24             	mov    %esi,(%esp)
80102d46:	e8 f5 d2 ff ff       	call   80100040 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d4b:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102d51:	7c 8d                	jl     80102ce0 <end_op+0x60>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d53:	e8 b8 fe ff ff       	call   80102c10 <write_head>
    install_trans(); // Now install writes to home locations
80102d58:	e8 13 fe ff ff       	call   80102b70 <install_trans>
    log.lh.n = 0;
80102d5d:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d64:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d67:	e8 a4 fe ff ff       	call   80102c10 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102d6c:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d73:	e8 18 18 00 00       	call   80104590 <acquire>
    log.committing = 0;
80102d78:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102d7f:	00 00 00 
    wakeup(&log);
80102d82:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d89:	e8 12 0b 00 00       	call   801038a0 <wakeup>
    release(&log.lock);
80102d8e:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d95:	e8 a6 17 00 00       	call   80104540 <release>
  }
}
80102d9a:	83 c4 1c             	add    $0x1c,%esp
80102d9d:	5b                   	pop    %ebx
80102d9e:	5e                   	pop    %esi
80102d9f:	5f                   	pop    %edi
80102da0:	5d                   	pop    %ebp
80102da1:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102da2:	c7 04 24 9d 76 10 80 	movl   $0x8010769d,(%esp)
80102da9:	e8 22 d6 ff ff       	call   801003d0 <panic>
80102dae:	66 90                	xchg   %ax,%ax

80102db0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102db0:	55                   	push   %ebp
80102db1:	89 e5                	mov    %esp,%ebp
80102db3:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102db6:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dbd:	e8 ce 17 00 00       	call   80104590 <acquire>
80102dc2:	eb 18                	jmp    80102ddc <begin_op+0x2c>
80102dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80102dc8:	c7 44 24 04 a0 26 11 	movl   $0x801126a0,0x4(%esp)
80102dcf:	80 
80102dd0:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dd7:	e8 24 0c 00 00       	call   80103a00 <sleep>
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102ddc:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102de1:	85 c0                	test   %eax,%eax
80102de3:	75 e3                	jne    80102dc8 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102de5:	8b 15 dc 26 11 80    	mov    0x801126dc,%edx
80102deb:	83 c2 01             	add    $0x1,%edx
80102dee:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102df1:	01 c0                	add    %eax,%eax
80102df3:	03 05 e8 26 11 80    	add    0x801126e8,%eax
80102df9:	83 f8 1e             	cmp    $0x1e,%eax
80102dfc:	7f ca                	jg     80102dc8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102dfe:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102e05:	89 15 dc 26 11 80    	mov    %edx,0x801126dc
      release(&log.lock);
80102e0b:	e8 30 17 00 00       	call   80104540 <release>
      break;
    }
  }
}
80102e10:	c9                   	leave  
80102e11:	c3                   	ret    
80102e12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e20 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	56                   	push   %esi
80102e24:	53                   	push   %ebx
80102e25:	83 ec 30             	sub    $0x30,%esp
80102e28:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102e2b:	c7 44 24 04 ac 76 10 	movl   $0x801076ac,0x4(%esp)
80102e32:	80 
80102e33:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e3a:	e8 c1 15 00 00       	call   80104400 <initlock>
  readsb(dev, &sb);
80102e3f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102e42:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e46:	89 1c 24             	mov    %ebx,(%esp)
80102e49:	e8 f2 e4 ff ff       	call   80101340 <readsb>
  log.start = sb.logstart;
80102e4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102e51:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.dev = dev;
80102e54:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102e5a:	89 1c 24             	mov    %ebx,(%esp)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102e5d:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102e62:	89 15 d8 26 11 80    	mov    %edx,0x801126d8

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102e68:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e6c:	e8 9f d2 ff ff       	call   80100110 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102e71:	8b 58 5c             	mov    0x5c(%eax),%ebx
// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
80102e74:	8d 70 5c             	lea    0x5c(%eax),%esi
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102e77:	85 db                	test   %ebx,%ebx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102e79:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102e7f:	7e 19                	jle    80102e9a <initlog+0x7a>
80102e81:	31 d2                	xor    %edx,%edx
80102e83:	90                   	nop
80102e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102e88:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102e8c:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102e93:	83 c2 01             	add    $0x1,%edx
80102e96:	39 da                	cmp    %ebx,%edx
80102e98:	75 ee                	jne    80102e88 <initlog+0x68>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102e9a:	89 04 24             	mov    %eax,(%esp)
80102e9d:	e8 9e d1 ff ff       	call   80100040 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102ea2:	e8 c9 fc ff ff       	call   80102b70 <install_trans>
  log.lh.n = 0;
80102ea7:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102eae:	00 00 00 
  write_head(); // clear the log
80102eb1:	e8 5a fd ff ff       	call   80102c10 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102eb6:	83 c4 30             	add    $0x30,%esp
80102eb9:	5b                   	pop    %ebx
80102eba:	5e                   	pop    %esi
80102ebb:	5d                   	pop    %ebp
80102ebc:	c3                   	ret    
80102ebd:	00 00                	add    %al,(%eax)
	...

80102ec0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102ec0:	55                   	push   %ebp
80102ec1:	89 e5                	mov    %esp,%ebp
80102ec3:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpunum());
80102ec6:	e8 55 fb ff ff       	call   80102a20 <cpunum>
80102ecb:	c7 04 24 b0 76 10 80 	movl   $0x801076b0,(%esp)
80102ed2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ed6:	e8 95 d9 ff ff       	call   80100870 <cprintf>
  idtinit();       // load idt register
80102edb:	e8 a0 2a 00 00       	call   80105980 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102ee0:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102ee7:	b8 01 00 00 00       	mov    $0x1,%eax
80102eec:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102ef3:	e8 18 0c 00 00       	call   80103b10 <scheduler>
80102ef8:	90                   	nop
80102ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f00 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	83 e4 f0             	and    $0xfffffff0,%esp
80102f06:	53                   	push   %ebx
80102f07:	83 ec 1c             	sub    $0x1c,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f0a:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102f11:	80 
80102f12:	c7 04 24 28 57 11 80 	movl   $0x80115728,(%esp)
80102f19:	e8 b2 f5 ff ff       	call   801024d0 <kinit1>
  kvmalloc();      // kernel page table
80102f1e:	e8 cd 3b 00 00       	call   80106af0 <kvmalloc>
  mpinit();        // detect other processors
80102f23:	e8 c8 01 00 00       	call   801030f0 <mpinit>
  lapicinit();     // interrupt controller
80102f28:	e8 e3 f6 ff ff       	call   80102610 <lapicinit>
80102f2d:	8d 76 00             	lea    0x0(%esi),%esi
  seginit();       // segment descriptors
80102f30:	e8 4b 41 00 00       	call   80107080 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102f35:	e8 e6 fa ff ff       	call   80102a20 <cpunum>
80102f3a:	c7 04 24 c1 76 10 80 	movl   $0x801076c1,(%esp)
80102f41:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f45:	e8 26 d9 ff ff       	call   80100870 <cprintf>
  picinit();       // another interrupt controller
80102f4a:	e8 a1 03 00 00       	call   801032f0 <picinit>
  ioapicinit();    // another interrupt controller
80102f4f:	e8 4c f3 ff ff       	call   801022a0 <ioapicinit>
  consoleinit();   // console hardware
80102f54:	e8 17 d3 ff ff       	call   80100270 <consoleinit>
  uartinit();      // serial port
80102f59:	e8 f2 2d 00 00       	call   80105d50 <uartinit>
80102f5e:	66 90                	xchg   %ax,%ax
  pinit();         // process table
80102f60:	e8 6b 13 00 00       	call   801042d0 <pinit>
  tvinit();        // trap vectors
80102f65:	e8 b6 2c 00 00       	call   80105c20 <tvinit>
  binit();         // buffer cache
80102f6a:	e8 71 d2 ff ff       	call   801001e0 <binit>
80102f6f:	90                   	nop
  fileinit();      // file table
80102f70:	e8 cb e1 ff ff       	call   80101140 <fileinit>
  ideinit();       // disk
80102f75:	e8 46 f2 ff ff       	call   801021c0 <ideinit>
  if(!ismp)
80102f7a:	a1 84 27 11 80       	mov    0x80112784,%eax
80102f7f:	85 c0                	test   %eax,%eax
80102f81:	0f 84 ca 00 00 00    	je     80103051 <main+0x151>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f87:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102f8e:	00 
80102f8f:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102f96:	80 
80102f97:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102f9e:	e8 5d 17 00 00       	call   80104700 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102fa3:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80102faa:	00 00 00 
80102fad:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102fb2:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80102fb7:	76 7a                	jbe    80103033 <main+0x133>
80102fb9:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80102fbe:	66 90                	xchg   %ax,%ax
    if(c == cpus+cpunum())  // We've started already.
80102fc0:	e8 5b fa ff ff       	call   80102a20 <cpunum>
80102fc5:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80102fcb:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102fd0:	39 c3                	cmp    %eax,%ebx
80102fd2:	74 46                	je     8010301a <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102fd4:	e8 87 f3 ff ff       	call   80102360 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
80102fd9:	c7 05 f8 6f 00 80 60 	movl   $0x80103060,0x80006ff8
80102fe0:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102fe3:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102fea:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102fed:	05 00 10 00 00       	add    $0x1000,%eax
80102ff2:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102ff7:	0f b6 03             	movzbl (%ebx),%eax
80102ffa:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80103001:	00 
80103002:	89 04 24             	mov    %eax,(%esp)
80103005:	e8 76 f7 ff ff       	call   80102780 <lapicstartap>
8010300a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103010:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80103016:	85 c0                	test   %eax,%eax
80103018:	74 f6                	je     80103010 <main+0x110>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010301a:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80103021:	00 00 00 
80103024:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
8010302a:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010302f:	39 c3                	cmp    %eax,%ebx
80103031:	72 8d                	jb     80102fc0 <main+0xc0>
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103033:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
8010303a:	8e 
8010303b:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103042:	e8 59 f4 ff ff       	call   801024a0 <kinit2>
  userinit();      // first user process
80103047:	e8 84 11 00 00       	call   801041d0 <userinit>
  mpmain();        // finish this processor's setup
8010304c:	e8 6f fe ff ff       	call   80102ec0 <mpmain>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
80103051:	e8 ca 28 00 00       	call   80105920 <timerinit>
80103056:	e9 2c ff ff ff       	jmp    80102f87 <main+0x87>
8010305b:	90                   	nop
8010305c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103060 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103060:	55                   	push   %ebp
80103061:	89 e5                	mov    %esp,%ebp
80103063:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103066:	e8 15 38 00 00       	call   80106880 <switchkvm>
  seginit();
8010306b:	e8 10 40 00 00       	call   80107080 <seginit>
  lapicinit();
80103070:	e8 9b f5 ff ff       	call   80102610 <lapicinit>
  mpmain();
80103075:	e8 46 fe ff ff       	call   80102ec0 <mpmain>
8010307a:	00 00                	add    %al,(%eax)
8010307c:	00 00                	add    %al,(%eax)
	...

80103080 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103080:	55                   	push   %ebp
80103081:	89 e5                	mov    %esp,%ebp
80103083:	56                   	push   %esi
80103084:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
80103085:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010308b:	83 ec 10             	sub    $0x10,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010308e:	8d 34 13             	lea    (%ebx,%edx,1),%esi
  for(p = addr; p < e; p += sizeof(struct mp))
80103091:	39 f3                	cmp    %esi,%ebx
80103093:	73 3c                	jae    801030d1 <mpsearch1+0x51>
80103095:	8d 76 00             	lea    0x0(%esi),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103098:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010309f:	00 
801030a0:	c7 44 24 04 d8 76 10 	movl   $0x801076d8,0x4(%esp)
801030a7:	80 
801030a8:	89 1c 24             	mov    %ebx,(%esp)
801030ab:	e8 f0 15 00 00       	call   801046a0 <memcmp>
801030b0:	85 c0                	test   %eax,%eax
801030b2:	75 16                	jne    801030ca <mpsearch1+0x4a>
801030b4:	31 d2                	xor    %edx,%edx
801030b6:	66 90                	xchg   %ax,%ax
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801030b8:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030bc:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801030bf:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030c1:	83 f8 10             	cmp    $0x10,%eax
801030c4:	75 f2                	jne    801030b8 <mpsearch1+0x38>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030c6:	84 d2                	test   %dl,%dl
801030c8:	74 10                	je     801030da <mpsearch1+0x5a>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030ca:	83 c3 10             	add    $0x10,%ebx
801030cd:	39 de                	cmp    %ebx,%esi
801030cf:	77 c7                	ja     80103098 <mpsearch1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801030d1:	83 c4 10             	add    $0x10,%esp
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030d4:	31 c0                	xor    %eax,%eax
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801030d6:	5b                   	pop    %ebx
801030d7:	5e                   	pop    %esi
801030d8:	5d                   	pop    %ebp
801030d9:	c3                   	ret    
801030da:	83 c4 10             	add    $0x10,%esp

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
801030dd:	89 d8                	mov    %ebx,%eax
  return 0;
}
801030df:	5b                   	pop    %ebx
801030e0:	5e                   	pop    %esi
801030e1:	5d                   	pop    %ebp
801030e2:	c3                   	ret    
801030e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801030e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801030f0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801030f0:	55                   	push   %ebp
801030f1:	89 e5                	mov    %esp,%ebp
801030f3:	57                   	push   %edi
801030f4:	56                   	push   %esi
801030f5:	53                   	push   %ebx
801030f6:	83 ec 2c             	sub    $0x2c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801030f9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103100:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103107:	c1 e0 08             	shl    $0x8,%eax
8010310a:	09 d0                	or     %edx,%eax
8010310c:	c1 e0 04             	shl    $0x4,%eax
8010310f:	85 c0                	test   %eax,%eax
80103111:	75 1b                	jne    8010312e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103113:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010311a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103121:	c1 e0 08             	shl    $0x8,%eax
80103124:	09 d0                	or     %edx,%eax
80103126:	c1 e0 0a             	shl    $0xa,%eax
80103129:	2d 00 04 00 00       	sub    $0x400,%eax
8010312e:	ba 00 04 00 00       	mov    $0x400,%edx
80103133:	e8 48 ff ff ff       	call   80103080 <mpsearch1>
80103138:	85 c0                	test   %eax,%eax
8010313a:	89 c6                	mov    %eax,%esi
8010313c:	0f 84 a6 00 00 00    	je     801031e8 <mpinit+0xf8>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103142:	8b 7e 04             	mov    0x4(%esi),%edi
80103145:	85 ff                	test   %edi,%edi
80103147:	75 08                	jne    80103151 <mpinit+0x61>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103149:	83 c4 2c             	add    $0x2c,%esp
8010314c:	5b                   	pop    %ebx
8010314d:	5e                   	pop    %esi
8010314e:	5f                   	pop    %edi
8010314f:	5d                   	pop    %ebp
80103150:	c3                   	ret    
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103151:	8d 9f 00 00 00 80    	lea    -0x80000000(%edi),%ebx
  if(memcmp(conf, "PCMP", 4) != 0)
80103157:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010315e:	00 
8010315f:	c7 44 24 04 dd 76 10 	movl   $0x801076dd,0x4(%esp)
80103166:	80 
80103167:	89 1c 24             	mov    %ebx,(%esp)
8010316a:	e8 31 15 00 00       	call   801046a0 <memcmp>
8010316f:	85 c0                	test   %eax,%eax
80103171:	75 d6                	jne    80103149 <mpinit+0x59>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103173:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
80103177:	3c 04                	cmp    $0x4,%al
80103179:	74 04                	je     8010317f <mpinit+0x8f>
8010317b:	3c 01                	cmp    $0x1,%al
8010317d:	75 ca                	jne    80103149 <mpinit+0x59>
  *pmp = mp;
  return conf;
}

void
mpinit(void)
8010317f:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103183:	89 d8                	mov    %ebx,%eax
  *pmp = mp;
  return conf;
}

void
mpinit(void)
80103185:	8d 8c 17 00 00 00 80 	lea    -0x80000000(%edi,%edx,1),%ecx
8010318c:	31 d2                	xor    %edx,%edx
8010318e:	eb 08                	jmp    80103198 <mpinit+0xa8>
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103190:	0f b6 38             	movzbl (%eax),%edi
80103193:	83 c0 01             	add    $0x1,%eax
80103196:	01 fa                	add    %edi,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103198:	39 c8                	cmp    %ecx,%eax
8010319a:	75 f4                	jne    80103190 <mpinit+0xa0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
8010319c:	84 d2                	test   %dl,%dl
8010319e:	75 a9                	jne    80103149 <mpinit+0x59>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
801031a0:	c7 05 84 27 11 80 01 	movl   $0x1,0x80112784
801031a7:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
801031aa:	8b 43 24             	mov    0x24(%ebx),%eax
801031ad:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031b2:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
801031b6:	8d 43 2c             	lea    0x2c(%ebx),%eax
801031b9:	01 d3                	add    %edx,%ebx
801031bb:	39 d8                	cmp    %ebx,%eax
801031bd:	72 17                	jb     801031d6 <mpinit+0xe6>
801031bf:	eb 5f                	jmp    80103220 <mpinit+0x130>
801031c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801031c8:	c7 05 84 27 11 80 00 	movl   $0x0,0x80112784
801031cf:	00 00 00 

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031d2:	39 c3                	cmp    %eax,%ebx
801031d4:	76 41                	jbe    80103217 <mpinit+0x127>
    switch(*p){
801031d6:	80 38 04             	cmpb   $0x4,(%eax)
801031d9:	77 ed                	ja     801031c8 <mpinit+0xd8>
801031db:	0f b6 10             	movzbl (%eax),%edx
801031de:	ff 24 95 e4 76 10 80 	jmp    *-0x7fef891c(,%edx,4)
801031e5:	8d 76 00             	lea    0x0(%esi),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031e8:	ba 00 00 01 00       	mov    $0x10000,%edx
801031ed:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031f2:	e8 89 fe ff ff       	call   80103080 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031f7:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031f9:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031fb:	0f 85 41 ff ff ff    	jne    80103142 <mpinit+0x52>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103201:	83 c4 2c             	add    $0x2c,%esp
80103204:	5b                   	pop    %ebx
80103205:	5e                   	pop    %esi
80103206:	5f                   	pop    %edi
80103207:	5d                   	pop    %ebp
80103208:	c3                   	ret    
80103209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103210:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103213:	39 c3                	cmp    %eax,%ebx
80103215:	77 bf                	ja     801031d6 <mpinit+0xe6>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
80103217:	a1 84 27 11 80       	mov    0x80112784,%eax
8010321c:	85 c0                	test   %eax,%eax
8010321e:	74 70                	je     80103290 <mpinit+0x1a0>
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
80103220:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103224:	0f 84 1f ff ff ff    	je     80103149 <mpinit+0x59>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010322a:	ba 22 00 00 00       	mov    $0x22,%edx
8010322f:	b8 70 00 00 00       	mov    $0x70,%eax
80103234:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103235:	b2 23                	mov    $0x23,%dl
80103237:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103238:	83 c8 01             	or     $0x1,%eax
8010323b:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010323c:	83 c4 2c             	add    $0x2c,%esp
8010323f:	5b                   	pop    %ebx
80103240:	5e                   	pop    %esi
80103241:	5f                   	pop    %edi
80103242:	5d                   	pop    %ebp
80103243:	c3                   	ret    
80103244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103248:	8b 15 80 2d 11 80    	mov    0x80112d80,%edx
8010324e:	83 fa 07             	cmp    $0x7,%edx
80103251:	7f 1b                	jg     8010326e <mpinit+0x17e>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103253:	69 ca bc 00 00 00    	imul   $0xbc,%edx,%ecx
        ncpu++;
80103259:	83 c2 01             	add    $0x1,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010325c:	89 cf                	mov    %ecx,%edi
8010325e:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
        ncpu++;
80103262:	89 15 80 2d 11 80    	mov    %edx,0x80112d80
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103268:	88 8f a0 27 11 80    	mov    %cl,-0x7feed860(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010326e:	83 c0 14             	add    $0x14,%eax
      continue;
80103271:	e9 5c ff ff ff       	jmp    801031d2 <mpinit+0xe2>
80103276:	66 90                	xchg   %ax,%ax
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103278:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010327c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010327f:	88 15 80 27 11 80    	mov    %dl,0x80112780
      p += sizeof(struct mpioapic);
      continue;
80103285:	e9 48 ff ff ff       	jmp    801031d2 <mpinit+0xe2>
8010328a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      break;
    }
  }
  if(!ismp){
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103290:	c7 05 80 2d 11 80 01 	movl   $0x1,0x80112d80
80103297:	00 00 00 
    lapic = 0;
8010329a:	c7 05 9c 26 11 80 00 	movl   $0x0,0x8011269c
801032a1:	00 00 00 
    ioapicid = 0;
801032a4:	c6 05 80 27 11 80 00 	movb   $0x0,0x80112780
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801032ab:	83 c4 2c             	add    $0x2c,%esp
801032ae:	5b                   	pop    %ebx
801032af:	5e                   	pop    %esi
801032b0:	5f                   	pop    %edi
801032b1:	5d                   	pop    %ebp
801032b2:	c3                   	ret    
	...

801032c0 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
801032c0:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
801032c1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
801032c6:	89 e5                	mov    %esp,%ebp
801032c8:	ba 21 00 00 00       	mov    $0x21,%edx
  picsetmask(irqmask & ~(1<<irq));
801032cd:	8b 4d 08             	mov    0x8(%ebp),%ecx
801032d0:	d3 c0                	rol    %cl,%eax
801032d2:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
801032d9:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
801032df:	ee                   	out    %al,(%dx)
801032e0:	66 c1 e8 08          	shr    $0x8,%ax
801032e4:	b2 a1                	mov    $0xa1,%dl
801032e6:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
801032e7:	5d                   	pop    %ebp
801032e8:	c3                   	ret    
801032e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801032f0 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
801032f0:	55                   	push   %ebp
801032f1:	b9 21 00 00 00       	mov    $0x21,%ecx
801032f6:	89 e5                	mov    %esp,%ebp
801032f8:	83 ec 0c             	sub    $0xc,%esp
801032fb:	89 1c 24             	mov    %ebx,(%esp)
801032fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103303:	89 ca                	mov    %ecx,%edx
80103305:	89 74 24 04          	mov    %esi,0x4(%esp)
80103309:	89 7c 24 08          	mov    %edi,0x8(%esp)
8010330d:	ee                   	out    %al,(%dx)
8010330e:	bb a1 00 00 00       	mov    $0xa1,%ebx
80103313:	89 da                	mov    %ebx,%edx
80103315:	ee                   	out    %al,(%dx)
80103316:	be 11 00 00 00       	mov    $0x11,%esi
8010331b:	b2 20                	mov    $0x20,%dl
8010331d:	89 f0                	mov    %esi,%eax
8010331f:	ee                   	out    %al,(%dx)
80103320:	b8 20 00 00 00       	mov    $0x20,%eax
80103325:	89 ca                	mov    %ecx,%edx
80103327:	ee                   	out    %al,(%dx)
80103328:	b8 04 00 00 00       	mov    $0x4,%eax
8010332d:	ee                   	out    %al,(%dx)
8010332e:	bf 03 00 00 00       	mov    $0x3,%edi
80103333:	89 f8                	mov    %edi,%eax
80103335:	ee                   	out    %al,(%dx)
80103336:	b1 a0                	mov    $0xa0,%cl
80103338:	89 f0                	mov    %esi,%eax
8010333a:	89 ca                	mov    %ecx,%edx
8010333c:	ee                   	out    %al,(%dx)
8010333d:	b8 28 00 00 00       	mov    $0x28,%eax
80103342:	89 da                	mov    %ebx,%edx
80103344:	ee                   	out    %al,(%dx)
80103345:	b8 02 00 00 00       	mov    $0x2,%eax
8010334a:	ee                   	out    %al,(%dx)
8010334b:	89 f8                	mov    %edi,%eax
8010334d:	ee                   	out    %al,(%dx)
8010334e:	be 68 00 00 00       	mov    $0x68,%esi
80103353:	b2 20                	mov    $0x20,%dl
80103355:	89 f0                	mov    %esi,%eax
80103357:	ee                   	out    %al,(%dx)
80103358:	bb 0a 00 00 00       	mov    $0xa,%ebx
8010335d:	89 d8                	mov    %ebx,%eax
8010335f:	ee                   	out    %al,(%dx)
80103360:	89 f0                	mov    %esi,%eax
80103362:	89 ca                	mov    %ecx,%edx
80103364:	ee                   	out    %al,(%dx)
80103365:	89 d8                	mov    %ebx,%eax
80103367:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
80103368:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
8010336f:	66 83 f8 ff          	cmp    $0xffffffff,%ax
80103373:	74 0a                	je     8010337f <picinit+0x8f>
80103375:	b2 21                	mov    $0x21,%dl
80103377:	ee                   	out    %al,(%dx)
80103378:	66 c1 e8 08          	shr    $0x8,%ax
8010337c:	b2 a1                	mov    $0xa1,%dl
8010337e:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
8010337f:	8b 1c 24             	mov    (%esp),%ebx
80103382:	8b 74 24 04          	mov    0x4(%esp),%esi
80103386:	8b 7c 24 08          	mov    0x8(%esp),%edi
8010338a:	89 ec                	mov    %ebp,%esp
8010338c:	5d                   	pop    %ebp
8010338d:	c3                   	ret    
	...

80103390 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103390:	55                   	push   %ebp
80103391:	89 e5                	mov    %esp,%ebp
80103393:	57                   	push   %edi
80103394:	56                   	push   %esi
80103395:	53                   	push   %ebx
80103396:	83 ec 1c             	sub    $0x1c,%esp
80103399:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010339c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010339f:	89 1c 24             	mov    %ebx,(%esp)
801033a2:	e8 e9 11 00 00       	call   80104590 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801033a7:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
801033ad:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
801033b3:	75 58                	jne    8010340d <piperead+0x7d>
801033b5:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801033bb:	85 f6                	test   %esi,%esi
801033bd:	74 4e                	je     8010340d <piperead+0x7d>
    if(proc->killed){
801033bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801033c5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
801033cb:	8b 48 24             	mov    0x24(%eax),%ecx
801033ce:	85 c9                	test   %ecx,%ecx
801033d0:	74 21                	je     801033f3 <piperead+0x63>
801033d2:	e9 99 00 00 00       	jmp    80103470 <piperead+0xe0>
801033d7:	90                   	nop
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801033d8:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033de:	85 c0                	test   %eax,%eax
801033e0:	74 2b                	je     8010340d <piperead+0x7d>
    if(proc->killed){
801033e2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801033e8:	8b 50 24             	mov    0x24(%eax),%edx
801033eb:	85 d2                	test   %edx,%edx
801033ed:	0f 85 7d 00 00 00    	jne    80103470 <piperead+0xe0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801033f3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801033f7:	89 34 24             	mov    %esi,(%esp)
801033fa:	e8 01 06 00 00       	call   80103a00 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801033ff:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
80103405:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
8010340b:	74 cb                	je     801033d8 <piperead+0x48>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010340d:	85 ff                	test   %edi,%edi
8010340f:	7e 76                	jle    80103487 <piperead+0xf7>
    if(p->nread == p->nwrite)
80103411:	31 f6                	xor    %esi,%esi
80103413:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
80103419:	75 0d                	jne    80103428 <piperead+0x98>
8010341b:	eb 6a                	jmp    80103487 <piperead+0xf7>
8010341d:	8d 76 00             	lea    0x0(%esi),%esi
80103420:	39 93 38 02 00 00    	cmp    %edx,0x238(%ebx)
80103426:	74 22                	je     8010344a <piperead+0xba>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103428:	89 d0                	mov    %edx,%eax
8010342a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010342d:	83 c2 01             	add    $0x1,%edx
80103430:	25 ff 01 00 00       	and    $0x1ff,%eax
80103435:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
8010343a:	88 04 31             	mov    %al,(%ecx,%esi,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010343d:	83 c6 01             	add    $0x1,%esi
80103440:	39 f7                	cmp    %esi,%edi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103442:	89 93 34 02 00 00    	mov    %edx,0x234(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103448:	7f d6                	jg     80103420 <piperead+0x90>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010344a:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103450:	89 04 24             	mov    %eax,(%esp)
80103453:	e8 48 04 00 00       	call   801038a0 <wakeup>
  release(&p->lock);
80103458:	89 1c 24             	mov    %ebx,(%esp)
8010345b:	e8 e0 10 00 00       	call   80104540 <release>
  return i;
}
80103460:	83 c4 1c             	add    $0x1c,%esp
80103463:	89 f0                	mov    %esi,%eax
80103465:	5b                   	pop    %ebx
80103466:	5e                   	pop    %esi
80103467:	5f                   	pop    %edi
80103468:	5d                   	pop    %ebp
80103469:	c3                   	ret    
8010346a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
80103470:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103475:	89 1c 24             	mov    %ebx,(%esp)
80103478:	e8 c3 10 00 00       	call   80104540 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
8010347d:	83 c4 1c             	add    $0x1c,%esp
80103480:	89 f0                	mov    %esi,%eax
80103482:	5b                   	pop    %ebx
80103483:	5e                   	pop    %esi
80103484:	5f                   	pop    %edi
80103485:	5d                   	pop    %ebp
80103486:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103487:	31 f6                	xor    %esi,%esi
80103489:	eb bf                	jmp    8010344a <piperead+0xba>
8010348b:	90                   	nop
8010348c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103490 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103490:	55                   	push   %ebp
80103491:	89 e5                	mov    %esp,%ebp
80103493:	57                   	push   %edi
80103494:	56                   	push   %esi
80103495:	53                   	push   %ebx
80103496:	83 ec 3c             	sub    $0x3c,%esp
80103499:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010349c:	89 1c 24             	mov    %ebx,(%esp)
8010349f:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801034a5:	e8 e6 10 00 00       	call   80104590 <acquire>
  for(i = 0; i < n; i++){
801034aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
801034ad:	85 c9                	test   %ecx,%ecx
801034af:	0f 8e 8d 00 00 00    	jle    80103542 <pipewrite+0xb2>
801034b5:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034bb:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
801034c1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801034c8:	eb 37                	jmp    80103501 <pipewrite+0x71>
801034ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
801034d0:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034d6:	85 c0                	test   %eax,%eax
801034d8:	74 7e                	je     80103558 <pipewrite+0xc8>
801034da:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801034e0:	8b 50 24             	mov    0x24(%eax),%edx
801034e3:	85 d2                	test   %edx,%edx
801034e5:	75 71                	jne    80103558 <pipewrite+0xc8>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034e7:	89 34 24             	mov    %esi,(%esp)
801034ea:	e8 b1 03 00 00       	call   801038a0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034ef:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801034f3:	89 3c 24             	mov    %edi,(%esp)
801034f6:	e8 05 05 00 00       	call   80103a00 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034fb:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103501:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
80103507:	81 c2 00 02 00 00    	add    $0x200,%edx
8010350d:	39 d0                	cmp    %edx,%eax
8010350f:	74 bf                	je     801034d0 <pipewrite+0x40>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103511:	89 c2                	mov    %eax,%edx
80103513:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103516:	83 c0 01             	add    $0x1,%eax
80103519:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010351f:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80103522:	8b 55 0c             	mov    0xc(%ebp),%edx
80103525:	0f b6 0c 0a          	movzbl (%edx,%ecx,1),%ecx
80103529:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010352c:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
80103530:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103536:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010353a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010353d:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103540:	7f bf                	jg     80103501 <pipewrite+0x71>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103542:	89 34 24             	mov    %esi,(%esp)
80103545:	e8 56 03 00 00       	call   801038a0 <wakeup>
  release(&p->lock);
8010354a:	89 1c 24             	mov    %ebx,(%esp)
8010354d:	e8 ee 0f 00 00       	call   80104540 <release>
  return n;
80103552:	eb 13                	jmp    80103567 <pipewrite+0xd7>
80103554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
80103558:	89 1c 24             	mov    %ebx,(%esp)
8010355b:	e8 e0 0f 00 00       	call   80104540 <release>
80103560:	c7 45 10 ff ff ff ff 	movl   $0xffffffff,0x10(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103567:	8b 45 10             	mov    0x10(%ebp),%eax
8010356a:	83 c4 3c             	add    $0x3c,%esp
8010356d:	5b                   	pop    %ebx
8010356e:	5e                   	pop    %esi
8010356f:	5f                   	pop    %edi
80103570:	5d                   	pop    %ebp
80103571:	c3                   	ret    
80103572:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103580 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103580:	55                   	push   %ebp
80103581:	89 e5                	mov    %esp,%ebp
80103583:	83 ec 18             	sub    $0x18,%esp
80103586:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80103589:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010358c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010358f:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103592:	89 1c 24             	mov    %ebx,(%esp)
80103595:	e8 f6 0f 00 00       	call   80104590 <acquire>
  if(writable){
8010359a:	85 f6                	test   %esi,%esi
8010359c:	74 42                	je     801035e0 <pipeclose+0x60>
    p->writeopen = 0;
8010359e:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801035a5:	00 00 00 
    wakeup(&p->nread);
801035a8:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801035ae:	89 04 24             	mov    %eax,(%esp)
801035b1:	e8 ea 02 00 00       	call   801038a0 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801035b6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035bc:	85 c0                	test   %eax,%eax
801035be:	75 0a                	jne    801035ca <pipeclose+0x4a>
801035c0:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801035c6:	85 f6                	test   %esi,%esi
801035c8:	74 36                	je     80103600 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801035ca:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801035cd:	8b 75 fc             	mov    -0x4(%ebp),%esi
801035d0:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801035d3:	89 ec                	mov    %ebp,%esp
801035d5:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801035d6:	e9 65 0f 00 00       	jmp    80104540 <release>
801035db:	90                   	nop
801035dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
801035e0:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035e7:	00 00 00 
    wakeup(&p->nwrite);
801035ea:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801035f0:	89 04 24             	mov    %eax,(%esp)
801035f3:	e8 a8 02 00 00       	call   801038a0 <wakeup>
801035f8:	eb bc                	jmp    801035b6 <pipeclose+0x36>
801035fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103600:	89 1c 24             	mov    %ebx,(%esp)
80103603:	e8 38 0f 00 00       	call   80104540 <release>
    kfree((char*)p);
  } else
    release(&p->lock);
}
80103608:	8b 75 fc             	mov    -0x4(%ebp),%esi
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
8010360b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
8010360e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103611:	89 ec                	mov    %ebp,%esp
80103613:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103614:	e9 97 ed ff ff       	jmp    801023b0 <kfree>
80103619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103620 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103620:	55                   	push   %ebp
80103621:	89 e5                	mov    %esp,%ebp
80103623:	57                   	push   %edi
80103624:	56                   	push   %esi
80103625:	53                   	push   %ebx
80103626:	83 ec 1c             	sub    $0x1c,%esp
80103629:	8b 75 08             	mov    0x8(%ebp),%esi
8010362c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010362f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103635:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010363b:	e8 a0 d9 ff ff       	call   80100fe0 <filealloc>
80103640:	85 c0                	test   %eax,%eax
80103642:	89 06                	mov    %eax,(%esi)
80103644:	0f 84 9c 00 00 00    	je     801036e6 <pipealloc+0xc6>
8010364a:	e8 91 d9 ff ff       	call   80100fe0 <filealloc>
8010364f:	85 c0                	test   %eax,%eax
80103651:	89 03                	mov    %eax,(%ebx)
80103653:	0f 84 7f 00 00 00    	je     801036d8 <pipealloc+0xb8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103659:	e8 02 ed ff ff       	call   80102360 <kalloc>
8010365e:	85 c0                	test   %eax,%eax
80103660:	89 c7                	mov    %eax,%edi
80103662:	74 74                	je     801036d8 <pipealloc+0xb8>
    goto bad;
  p->readopen = 1;
80103664:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010366b:	00 00 00 
  p->writeopen = 1;
8010366e:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103675:	00 00 00 
  p->nwrite = 0;
80103678:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010367f:	00 00 00 
  p->nread = 0;
80103682:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103689:	00 00 00 
  initlock(&p->lock, "pipe");
8010368c:	89 04 24             	mov    %eax,(%esp)
8010368f:	c7 44 24 04 f8 76 10 	movl   $0x801076f8,0x4(%esp)
80103696:	80 
80103697:	e8 64 0d 00 00       	call   80104400 <initlock>
  (*f0)->type = FD_PIPE;
8010369c:	8b 06                	mov    (%esi),%eax
8010369e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801036a4:	8b 06                	mov    (%esi),%eax
801036a6:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801036aa:	8b 06                	mov    (%esi),%eax
801036ac:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801036b0:	8b 06                	mov    (%esi),%eax
801036b2:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801036b5:	8b 03                	mov    (%ebx),%eax
801036b7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801036bd:	8b 03                	mov    (%ebx),%eax
801036bf:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801036c3:	8b 03                	mov    (%ebx),%eax
801036c5:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801036c9:	8b 03                	mov    (%ebx),%eax
801036cb:	89 78 0c             	mov    %edi,0xc(%eax)
801036ce:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801036d0:	83 c4 1c             	add    $0x1c,%esp
801036d3:	5b                   	pop    %ebx
801036d4:	5e                   	pop    %esi
801036d5:	5f                   	pop    %edi
801036d6:	5d                   	pop    %ebp
801036d7:	c3                   	ret    

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801036d8:	8b 06                	mov    (%esi),%eax
801036da:	85 c0                	test   %eax,%eax
801036dc:	74 08                	je     801036e6 <pipealloc+0xc6>
    fileclose(*f0);
801036de:	89 04 24             	mov    %eax,(%esp)
801036e1:	e8 7a d9 ff ff       	call   80101060 <fileclose>
  if(*f1)
801036e6:	8b 13                	mov    (%ebx),%edx
801036e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801036ed:	85 d2                	test   %edx,%edx
801036ef:	74 df                	je     801036d0 <pipealloc+0xb0>
    fileclose(*f1);
801036f1:	89 14 24             	mov    %edx,(%esp)
801036f4:	e8 67 d9 ff ff       	call   80101060 <fileclose>
801036f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801036fe:	eb d0                	jmp    801036d0 <pipealloc+0xb0>

80103700 <setpriority>:
    sleep(proc, &ptable.lock);  //DOC: wait-sleep	status = p->status
  }
}

int setpriority(int priority)			//added lab1p2
{												//sets given priorty for given process
80103700:	55                   	push   %ebp
  
    //acquire(&ptable.lock);

    //for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      //if(p->pid == pid)
     proc->priority = priority; 
80103701:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    sleep(proc, &ptable.lock);  //DOC: wait-sleep	status = p->status
  }
}

int setpriority(int priority)			//added lab1p2
{												//sets given priorty for given process
80103707:	89 e5                	mov    %esp,%ebp
  
    //acquire(&ptable.lock);

    //for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      //if(p->pid == pid)
     proc->priority = priority; 
80103709:	8b 55 08             	mov    0x8(%ebp),%edx
8010370c:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //}

    //release(&ptable.lock);

    return 0;
}
80103712:	31 c0                	xor    %eax,%eax
80103714:	5d                   	pop    %ebp
80103715:	c3                   	ret    
80103716:	8d 76 00             	lea    0x0(%esi),%esi
80103719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103720 <hello>:
  }
}


void 
hello(void) {
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	83 ec 18             	sub    $0x18,%esp
	
	cprintf("\nHello!!!!!!! \n");
80103726:	c7 04 24 fd 76 10 80 	movl   $0x801076fd,(%esp)
8010372d:	e8 3e d1 ff ff       	call   80100870 <cprintf>
}
80103732:	c9                   	leave  
80103733:	c3                   	ret    
80103734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010373a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103740 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	57                   	push   %edi
80103744:	56                   	push   %esi
80103745:	53                   	push   %ebx
//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
80103746:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
{
8010374b:	83 ec 4c             	sub    $0x4c,%esp
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010374e:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103751:	eb 4e                	jmp    801037a1 <procdump+0x61>
80103753:	90                   	nop
80103754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103758:	8b 04 85 e0 77 10 80 	mov    -0x7fef8820(,%eax,4),%eax
8010375f:	85 c0                	test   %eax,%eax
80103761:	74 4a                	je     801037ad <procdump+0x6d>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
80103763:	89 44 24 08          	mov    %eax,0x8(%esp)
80103767:	8b 43 10             	mov    0x10(%ebx),%eax
8010376a:	8d 53 6c             	lea    0x6c(%ebx),%edx
8010376d:	89 54 24 0c          	mov    %edx,0xc(%esp)
80103771:	c7 04 24 11 77 10 80 	movl   $0x80107711,(%esp)
80103778:	89 44 24 04          	mov    %eax,0x4(%esp)
8010377c:	e8 ef d0 ff ff       	call   80100870 <cprintf>
    if(p->state == SLEEPING){
80103781:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80103785:	74 31                	je     801037b8 <procdump+0x78>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103787:	c7 04 24 d6 76 10 80 	movl   $0x801076d6,(%esp)
8010378e:	e8 dd d0 ff ff       	call   80100870 <cprintf>
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103793:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103799:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
8010379f:	74 57                	je     801037f8 <procdump+0xb8>
    if(p->state == UNUSED)
801037a1:	8b 43 0c             	mov    0xc(%ebx),%eax
801037a4:	85 c0                	test   %eax,%eax
801037a6:	74 eb                	je     80103793 <procdump+0x53>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801037a8:	83 f8 05             	cmp    $0x5,%eax
801037ab:	76 ab                	jbe    80103758 <procdump+0x18>
801037ad:	b8 0d 77 10 80       	mov    $0x8010770d,%eax
801037b2:	eb af                	jmp    80103763 <procdump+0x23>
801037b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
801037b8:	8b 43 1c             	mov    0x1c(%ebx),%eax
801037bb:	31 f6                	xor    %esi,%esi
801037bd:	89 7c 24 04          	mov    %edi,0x4(%esp)
801037c1:	8b 40 0c             	mov    0xc(%eax),%eax
801037c4:	83 c0 08             	add    $0x8,%eax
801037c7:	89 04 24             	mov    %eax,(%esp)
801037ca:	e8 51 0c 00 00       	call   80104420 <getcallerpcs>
801037cf:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
801037d0:	8b 04 b7             	mov    (%edi,%esi,4),%eax
801037d3:	85 c0                	test   %eax,%eax
801037d5:	74 b0                	je     80103787 <procdump+0x47>
801037d7:	83 c6 01             	add    $0x1,%esi
        cprintf(" %p", pc[i]);
801037da:	89 44 24 04          	mov    %eax,0x4(%esp)
801037de:	c7 04 24 11 72 10 80 	movl   $0x80107211,(%esp)
801037e5:	e8 86 d0 ff ff       	call   80100870 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801037ea:	83 fe 0a             	cmp    $0xa,%esi
801037ed:	75 e1                	jne    801037d0 <procdump+0x90>
801037ef:	eb 96                	jmp    80103787 <procdump+0x47>
801037f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801037f8:	83 c4 4c             	add    $0x4c,%esp
801037fb:	5b                   	pop    %ebx
801037fc:	5e                   	pop    %esi
801037fd:	5f                   	pop    %edi
801037fe:	5d                   	pop    %ebp
801037ff:	90                   	nop
80103800:	c3                   	ret    
80103801:	eb 0d                	jmp    80103810 <kill>
80103803:	90                   	nop
80103804:	90                   	nop
80103805:	90                   	nop
80103806:	90                   	nop
80103807:	90                   	nop
80103808:	90                   	nop
80103809:	90                   	nop
8010380a:	90                   	nop
8010380b:	90                   	nop
8010380c:	90                   	nop
8010380d:	90                   	nop
8010380e:	90                   	nop
8010380f:	90                   	nop

80103810 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	53                   	push   %ebx
80103814:	83 ec 14             	sub    $0x14,%esp
80103817:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010381a:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103821:	e8 6a 0d 00 00       	call   80104590 <acquire>

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
80103826:	b8 58 2e 11 80       	mov    $0x80112e58,%eax
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
8010382b:	39 1d e4 2d 11 80    	cmp    %ebx,0x80112de4
80103831:	75 11                	jne    80103844 <kill+0x34>
80103833:	eb 62                	jmp    80103897 <kill+0x87>
80103835:	8d 76 00             	lea    0x0(%esi),%esi
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103838:	05 84 00 00 00       	add    $0x84,%eax
8010383d:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103842:	74 3c                	je     80103880 <kill+0x70>
    if(p->pid == pid){
80103844:	39 58 10             	cmp    %ebx,0x10(%eax)
80103847:	75 ef                	jne    80103838 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103849:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
8010384d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103854:	74 1a                	je     80103870 <kill+0x60>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103856:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010385d:	e8 de 0c 00 00       	call   80104540 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103862:	83 c4 14             	add    $0x14,%esp
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
80103865:	31 c0                	xor    %eax,%eax
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103867:	5b                   	pop    %ebx
80103868:	5d                   	pop    %ebp
80103869:	c3                   	ret    
8010386a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103870:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103877:	eb dd                	jmp    80103856 <kill+0x46>
80103879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80103880:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103887:	e8 b4 0c 00 00       	call   80104540 <release>
  return -1;
}
8010388c:	83 c4 14             	add    $0x14,%esp
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
8010388f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
80103894:	5b                   	pop    %ebx
80103895:	5d                   	pop    %ebp
80103896:	c3                   	ret    
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
80103897:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
8010389c:	eb ab                	jmp    80103849 <kill+0x39>
8010389e:	66 90                	xchg   %ax,%ax

801038a0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	53                   	push   %ebx
801038a4:	83 ec 14             	sub    $0x14,%esp
801038a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801038aa:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801038b1:	e8 da 0c 00 00       	call   80104590 <acquire>
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
801038b6:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
801038bb:	eb 0f                	jmp    801038cc <wakeup+0x2c>
801038bd:	8d 76 00             	lea    0x0(%esi),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038c0:	05 84 00 00 00       	add    $0x84,%eax
801038c5:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
801038ca:	74 24                	je     801038f0 <wakeup+0x50>
    if(p->state == SLEEPING && p->chan == chan)
801038cc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801038d0:	75 ee                	jne    801038c0 <wakeup+0x20>
801038d2:	3b 58 20             	cmp    0x20(%eax),%ebx
801038d5:	75 e9                	jne    801038c0 <wakeup+0x20>
      p->state = RUNNABLE;
801038d7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038de:	05 84 00 00 00       	add    $0x84,%eax
801038e3:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
801038e8:	75 e2                	jne    801038cc <wakeup+0x2c>
801038ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801038f0:	c7 45 08 a0 2d 11 80 	movl   $0x80112da0,0x8(%ebp)
}
801038f7:	83 c4 14             	add    $0x14,%esp
801038fa:	5b                   	pop    %ebx
801038fb:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801038fc:	e9 3f 0c 00 00       	jmp    80104540 <release>
80103901:	eb 0d                	jmp    80103910 <forkret>
80103903:	90                   	nop
80103904:	90                   	nop
80103905:	90                   	nop
80103906:	90                   	nop
80103907:	90                   	nop
80103908:	90                   	nop
80103909:	90                   	nop
8010390a:	90                   	nop
8010390b:	90                   	nop
8010390c:	90                   	nop
8010390d:	90                   	nop
8010390e:	90                   	nop
8010390f:	90                   	nop

80103910 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103916:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010391d:	e8 1e 0c 00 00       	call   80104540 <release>

  if (first) {
80103922:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80103927:	85 c0                	test   %eax,%eax
80103929:	75 05                	jne    80103930 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010392b:	c9                   	leave  
8010392c:	c3                   	ret    
8010392d:	8d 76 00             	lea    0x0(%esi),%esi
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103930:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103937:	c7 05 08 a0 10 80 00 	movl   $0x0,0x8010a008
8010393e:	00 00 00 
    iinit(ROOTDEV);
80103941:	e8 9a e5 ff ff       	call   80101ee0 <iinit>
    initlog(ROOTDEV);
80103946:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010394d:	e8 ce f4 ff ff       	call   80102e20 <initlog>
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103952:	c9                   	leave  
80103953:	c3                   	ret    
80103954:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010395a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103960 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	53                   	push   %ebx
80103964:	83 ec 14             	sub    $0x14,%esp
  int intena;

  if(!holding(&ptable.lock))
80103967:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010396e:	e8 0d 0b 00 00       	call   80104480 <holding>
80103973:	85 c0                	test   %eax,%eax
80103975:	74 4d                	je     801039c4 <sched+0x64>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
80103977:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010397d:	83 b8 ac 00 00 00 01 	cmpl   $0x1,0xac(%eax)
80103984:	75 62                	jne    801039e8 <sched+0x88>
    panic("sched locks");
  if(proc->state == RUNNING)
80103986:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010398d:	83 7a 0c 04          	cmpl   $0x4,0xc(%edx)
80103991:	74 49                	je     801039dc <sched+0x7c>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103993:	9c                   	pushf  
80103994:	59                   	pop    %ecx
    panic("sched running");
  if(readeflags()&FL_IF)
80103995:	80 e5 02             	and    $0x2,%ch
80103998:	75 36                	jne    801039d0 <sched+0x70>
    panic("sched interruptible");
  intena = cpu->intena;
8010399a:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  swtch(&proc->context, cpu->scheduler);
801039a0:	83 c2 1c             	add    $0x1c,%edx
801039a3:	8b 40 04             	mov    0x4(%eax),%eax
801039a6:	89 14 24             	mov    %edx,(%esp)
801039a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801039ad:	e8 ca 0e 00 00       	call   8010487c <swtch>
  cpu->intena = intena;
801039b2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801039b8:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
801039be:	83 c4 14             	add    $0x14,%esp
801039c1:	5b                   	pop    %ebx
801039c2:	5d                   	pop    %ebp
801039c3:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
801039c4:	c7 04 24 1a 77 10 80 	movl   $0x8010771a,(%esp)
801039cb:	e8 00 ca ff ff       	call   801003d0 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
801039d0:	c7 04 24 46 77 10 80 	movl   $0x80107746,(%esp)
801039d7:	e8 f4 c9 ff ff       	call   801003d0 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
801039dc:	c7 04 24 38 77 10 80 	movl   $0x80107738,(%esp)
801039e3:	e8 e8 c9 ff ff       	call   801003d0 <panic>
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
801039e8:	c7 04 24 2c 77 10 80 	movl   $0x8010772c,(%esp)
801039ef:	e8 dc c9 ff ff       	call   801003d0 <panic>
801039f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801039fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103a00 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	56                   	push   %esi
80103a04:	53                   	push   %ebx
80103a05:	83 ec 10             	sub    $0x10,%esp
  if(proc == 0)
80103a08:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103a0e:	8b 75 08             	mov    0x8(%ebp),%esi
80103a11:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103a14:	85 c0                	test   %eax,%eax
80103a16:	0f 84 a1 00 00 00    	je     80103abd <sleep+0xbd>
    panic("sleep");

  if(lk == 0)
80103a1c:	85 db                	test   %ebx,%ebx
80103a1e:	0f 84 8d 00 00 00    	je     80103ab1 <sleep+0xb1>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103a24:	81 fb a0 2d 11 80    	cmp    $0x80112da0,%ebx
80103a2a:	74 5c                	je     80103a88 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103a2c:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103a33:	e8 58 0b 00 00       	call   80104590 <acquire>
    release(lk);
80103a38:	89 1c 24             	mov    %ebx,(%esp)
80103a3b:	e8 00 0b 00 00       	call   80104540 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80103a40:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a46:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103a49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a4f:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103a56:	e8 05 ff ff ff       	call   80103960 <sched>

  // Tidy up.
  proc->chan = 0;
80103a5b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a61:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103a68:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103a6f:	e8 cc 0a 00 00       	call   80104540 <release>
    acquire(lk);
80103a74:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
80103a77:	83 c4 10             	add    $0x10,%esp
80103a7a:	5b                   	pop    %ebx
80103a7b:	5e                   	pop    %esi
80103a7c:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103a7d:	e9 0e 0b 00 00       	jmp    80104590 <acquire>
80103a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
80103a88:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103a8b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a91:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103a98:	e8 c3 fe ff ff       	call   80103960 <sched>

  // Tidy up.
  proc->chan = 0;
80103a9d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103aa3:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103aaa:	83 c4 10             	add    $0x10,%esp
80103aad:	5b                   	pop    %ebx
80103aae:	5e                   	pop    %esi
80103aaf:	5d                   	pop    %ebp
80103ab0:	c3                   	ret    
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103ab1:	c7 04 24 60 77 10 80 	movl   $0x80107760,(%esp)
80103ab8:	e8 13 c9 ff ff       	call   801003d0 <panic>
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
80103abd:	c7 04 24 5a 77 10 80 	movl   $0x8010775a,(%esp)
80103ac4:	e8 07 c9 ff ff       	call   801003d0 <panic>
80103ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ad0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ad6:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103add:	e8 ae 0a 00 00       	call   80104590 <acquire>
  proc->state = RUNNABLE;
80103ae2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ae8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103aef:	e8 6c fe ff ff       	call   80103960 <sched>
  release(&ptable.lock);
80103af4:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103afb:	e8 40 0a 00 00       	call   80104540 <release>
}
80103b00:	c9                   	leave  
80103b01:	c3                   	ret    
80103b02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b10 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void) 							//Lab 1 part 2 editing scheduler
{
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	56                   	push   %esi
80103b14:	53                   	push   %ebx
80103b15:	83 ec 10             	sub    $0x10,%esp
}

static inline void
sti(void)
{
  asm volatile("sti");
80103b18:	fb                   	sti    
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void) 							//Lab 1 part 2 editing scheduler
80103b19:	be 40 00 00 00       	mov    $0x40,%esi
    // Enable interrupts on this processor.
    sti();
	highest_Priority = 64;

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b1e:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b25:	e8 66 0a 00 00       	call   80104590 <acquire>
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void) 							//Lab 1 part 2 editing scheduler
80103b2a:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103b2f:	eb 13                	jmp    80103b44 <scheduler+0x34>
80103b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sti();
	highest_Priority = 64;

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b38:	05 84 00 00 00       	add    $0x84,%eax
80103b3d:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103b42:	74 1d                	je     80103b61 <scheduler+0x51>
      if(p->state != RUNNABLE)
80103b44:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103b48:	75 ee                	jne    80103b38 <scheduler+0x28>
80103b4a:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80103b50:	39 d6                	cmp    %edx,%esi
80103b52:	0f 4f f2             	cmovg  %edx,%esi
    sti();
	highest_Priority = 64;

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b55:	05 84 00 00 00       	add    $0x84,%eax
80103b5a:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103b5f:	75 e3                	jne    80103b44 <scheduler+0x34>
80103b61:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103b66:	eb 0e                	jmp    80103b76 <scheduler+0x66>
      {										
		  highest_Priority = p->priority;	//save the highest priority (lowest number_ into the struct)
		  //proc = p;							//run the proccess.
	  }
	}
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b68:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103b6e:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103b74:	74 5a                	je     80103bd0 <scheduler+0xc0>
    {
      if(p->state != RUNNABLE || p->priority != highest_Priority)
80103b76:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103b7a:	75 ec                	jne    80103b68 <scheduler+0x58>
80103b7c:	39 b3 80 00 00 00    	cmp    %esi,0x80(%ebx)
80103b82:	75 e4                	jne    80103b68 <scheduler+0x58>
      // before jumping back to us.
      
      //edited for lab 1 part 2 round robin scheduler
      //if(proc != 0) //created if statement that makes sure proc is not 0
      //{
		proc = p;
80103b84:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
		switchuvm(p);
80103b8b:	89 1c 24             	mov    %ebx,(%esp)
80103b8e:	e8 0d 34 00 00       	call   80106fa0 <switchuvm>
		p->state = RUNNING;
		swtch(&cpu->scheduler, p->context);
80103b93:	8b 43 1c             	mov    0x1c(%ebx),%eax
      //edited for lab 1 part 2 round robin scheduler
      //if(proc != 0) //created if statement that makes sure proc is not 0
      //{
		proc = p;
		switchuvm(p);
		p->state = RUNNING;
80103b96:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      {										
		  highest_Priority = p->priority;	//save the highest priority (lowest number_ into the struct)
		  //proc = p;							//run the proccess.
	  }
	}
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b9d:	81 c3 84 00 00 00    	add    $0x84,%ebx
      //if(proc != 0) //created if statement that makes sure proc is not 0
      //{
		proc = p;
		switchuvm(p);
		p->state = RUNNING;
		swtch(&cpu->scheduler, p->context);
80103ba3:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ba7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103bad:	83 c0 04             	add    $0x4,%eax
80103bb0:	89 04 24             	mov    %eax,(%esp)
80103bb3:	e8 c4 0c 00 00       	call   8010487c <swtch>
		switchkvm();
80103bb8:	e8 c3 2c 00 00       	call   80106880 <switchkvm>
      {										
		  highest_Priority = p->priority;	//save the highest priority (lowest number_ into the struct)
		  //proc = p;							//run the proccess.
	  }
	}
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bbd:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
		swtch(&cpu->scheduler, p->context);
		switchkvm();

		// Process is done running for now.
		// It should have changed its p->state before coming back.
		proc = 0;
80103bc3:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103bca:	00 00 00 00 
      {										
		  highest_Priority = p->priority;	//save the highest priority (lowest number_ into the struct)
		  //proc = p;							//run the proccess.
	  }
	}
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bce:	75 a6                	jne    80103b76 <scheduler+0x66>
		// Process is done running for now.
		// It should have changed its p->state before coming back.
		proc = 0;
	  }
      
    release(&ptable.lock);
80103bd0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103bd7:	e8 64 09 00 00       	call   80104540 <release>

  }
80103bdc:	e9 37 ff ff ff       	jmp    80103b18 <scheduler+0x8>
80103be1:	eb 0d                	jmp    80103bf0 <waitpid>
80103be3:	90                   	nop
80103be4:	90                   	nop
80103be5:	90                   	nop
80103be6:	90                   	nop
80103be7:	90                   	nop
80103be8:	90                   	nop
80103be9:	90                   	nop
80103bea:	90                   	nop
80103beb:	90                   	nop
80103bec:	90                   	nop
80103bed:	90                   	nop
80103bee:	90                   	nop
80103bef:	90                   	nop

80103bf0 <waitpid>:
  }
}

int 
waitpid(int pid, int* status, int options)		//added lab1 part1 
{													//exactly the same as wait 
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	57                   	push   %edi
80103bf4:	56                   	push   %esi
80103bf5:	53                   	push   %ebx
													//but now searches for passed in pid
  struct proc *p;									//pid flag substituted for child flag
  int foundPid;

  acquire(&ptable.lock);
80103bf6:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
  }
}

int 
waitpid(int pid, int* status, int options)		//added lab1 part1 
{													//exactly the same as wait 
80103bfb:	83 ec 1c             	sub    $0x1c,%esp
80103bfe:	8b 75 08             	mov    0x8(%ebp),%esi
80103c01:	8b 7d 0c             	mov    0xc(%ebp),%edi
													//but now searches for passed in pid
  struct proc *p;									//pid flag substituted for child flag
  int foundPid;

  acquire(&ptable.lock);
80103c04:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103c0b:	e8 80 09 00 00       	call   80104590 <acquire>
80103c10:	31 d2                	xor    %edx,%edx
80103c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(;;){
    // Scan through table looking for matching pid
    foundPid = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c18:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103c1e:	72 31                	jb     80103c51 <waitpid+0x61>
	  return pid;
	  }
    }

    // If pid not found or killed(ERROR) has occured same as wait function
    if(!foundPid || proc->killed){
80103c20:	85 d2                	test   %edx,%edx
80103c22:	74 4c                	je     80103c70 <waitpid+0x80>
80103c24:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c2b:	8b 4a 24             	mov    0x24(%edx),%ecx
80103c2e:	85 c9                	test   %ecx,%ecx
80103c30:	75 3e                	jne    80103c70 <waitpid+0x80>
      release(&ptable.lock);
      return -1;
    }

    // Wait for found to exit 
    sleep(proc, &ptable.lock);  //DOC: wait-sleep	status = p->status
80103c32:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103c37:	89 14 24             	mov    %edx,(%esp)
80103c3a:	c7 44 24 04 a0 2d 11 	movl   $0x80112da0,0x4(%esp)
80103c41:	80 
80103c42:	e8 b9 fd ff ff       	call   80103a00 <sleep>
80103c47:	31 d2                	xor    %edx,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for matching pid
    foundPid = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c49:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103c4f:	73 cf                	jae    80103c20 <waitpid+0x30>
      if(p->pid != pid)
80103c51:	39 73 10             	cmp    %esi,0x10(%ebx)
80103c54:	74 0a                	je     80103c60 <waitpid+0x70>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for matching pid
    foundPid = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c56:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103c5c:	eb ba                	jmp    80103c18 <waitpid+0x28>
80103c5e:	66 90                	xchg   %ax,%ax
      if(p->pid != pid)
        continue;
      foundPid = 1;
      if(p->state == ZOMBIE){
80103c60:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103c64:	74 25                	je     80103c8b <waitpid+0x9b>
		if(status != 0){			//same as wait function addition
			*status = p->status;
		}
      release(&ptable.lock);
        
	  return pid;
80103c66:	ba 01 00 00 00       	mov    $0x1,%edx
80103c6b:	eb e9                	jmp    80103c56 <waitpid+0x66>
80103c6d:	8d 76 00             	lea    0x0(%esi),%esi
	  }
    }

    // If pid not found or killed(ERROR) has occured same as wait function
    if(!foundPid || proc->killed){
      release(&ptable.lock);
80103c70:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103c75:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103c7c:	e8 bf 08 00 00       	call   80104540 <release>
    }

    // Wait for found to exit 
    sleep(proc, &ptable.lock);  //DOC: wait-sleep	status = p->status
  }
}
80103c81:	83 c4 1c             	add    $0x1c,%esp
80103c84:	89 f0                	mov    %esi,%eax
80103c86:	5b                   	pop    %ebx
80103c87:	5e                   	pop    %esi
80103c88:	5f                   	pop    %edi
80103c89:	5d                   	pop    %ebp
80103c8a:	c3                   	ret    
        continue;
      foundPid = 1;
      if(p->state == ZOMBIE){
        // match pid
        pid = p->pid;
        kfree(p->kstack);
80103c8b:	8b 43 08             	mov    0x8(%ebx),%eax
80103c8e:	89 04 24             	mov    %eax,(%esp)
80103c91:	e8 1a e7 ff ff       	call   801023b0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103c96:	8b 43 04             	mov    0x4(%ebx),%eax
      foundPid = 1;
      if(p->state == ZOMBIE){
        // match pid
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103c99:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103ca0:	89 04 24             	mov    %eax,(%esp)
80103ca3:	e8 c8 2f 00 00       	call   80106c70 <freevm>
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;

		if(status != 0){			//same as wait function addition
80103ca8:	85 ff                	test   %edi,%edi
        // match pid
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
80103caa:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103cb1:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103cb8:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103cbc:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103cc3:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)

		if(status != 0){			//same as wait function addition
80103cca:	74 05                	je     80103cd1 <waitpid+0xe1>
			*status = p->status;
80103ccc:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103ccf:	89 07                	mov    %eax,(%edi)
		}
      release(&ptable.lock);
80103cd1:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103cd8:	e8 63 08 00 00       	call   80104540 <release>
    }

    // Wait for found to exit 
    sleep(proc, &ptable.lock);  //DOC: wait-sleep	status = p->status
  }
}
80103cdd:	83 c4 1c             	add    $0x1c,%esp
80103ce0:	89 f0                	mov    %esi,%eax
80103ce2:	5b                   	pop    %ebx
80103ce3:	5e                   	pop    %esi
80103ce4:	5f                   	pop    %edi
80103ce5:	5d                   	pop    %ebp
80103ce6:	c3                   	ret    
80103ce7:	89 f6                	mov    %esi,%esi
80103ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cf0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(int *status)
{
80103cf0:	55                   	push   %ebp
80103cf1:	89 e5                	mov    %esp,%ebp
80103cf3:	56                   	push   %esi
80103cf4:	53                   	push   %ebx
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80103cf5:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(int *status)
{
80103cfa:	83 ec 20             	sub    $0x20,%esp
80103cfd:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80103d00:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103d07:	e8 84 08 00 00       	call   80104590 <acquire>
80103d0c:	31 c0                	xor    %eax,%eax
80103d0e:	66 90                	xchg   %ax,%ax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d10:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103d16:	72 30                	jb     80103d48 <wait+0x58>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103d18:	85 c0                	test   %eax,%eax
80103d1a:	74 54                	je     80103d70 <wait+0x80>
80103d1c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d22:	8b 58 24             	mov    0x24(%eax),%ebx
80103d25:	85 db                	test   %ebx,%ebx
80103d27:	75 47                	jne    80103d70 <wait+0x80>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80103d29:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103d2e:	89 04 24             	mov    %eax,(%esp)
80103d31:	c7 44 24 04 a0 2d 11 	movl   $0x80112da0,0x4(%esp)
80103d38:	80 
80103d39:	e8 c2 fc ff ff       	call   80103a00 <sleep>
80103d3e:	31 c0                	xor    %eax,%eax

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d40:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103d46:	73 d0                	jae    80103d18 <wait+0x28>
      if(p->parent != proc)
80103d48:	8b 53 14             	mov    0x14(%ebx),%edx
80103d4b:	65 3b 15 04 00 00 00 	cmp    %gs:0x4,%edx
80103d52:	74 0c                	je     80103d60 <wait+0x70>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d54:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103d5a:	eb b4                	jmp    80103d10 <wait+0x20>
80103d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103d60:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103d64:	74 22                	je     80103d88 <wait+0x98>
        if(status != 0) {			//lab1 part 1b set status if status is not null
			*status = p->status;
		}
		
        release(&ptable.lock);
        return pid;
80103d66:	b8 01 00 00 00       	mov    $0x1,%eax
80103d6b:	eb e7                	jmp    80103d54 <wait+0x64>
80103d6d:	8d 76 00             	lea    0x0(%esi),%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
80103d70:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103d77:	e8 c4 07 00 00       	call   80104540 <release>
80103d7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103d81:	83 c4 20             	add    $0x20,%esp
80103d84:	5b                   	pop    %ebx
80103d85:	5e                   	pop    %esi
80103d86:	5d                   	pop    %ebp
80103d87:	c3                   	ret    
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103d88:	8b 43 10             	mov    0x10(%ebx),%eax
        kfree(p->kstack);
80103d8b:	8b 53 08             	mov    0x8(%ebx),%edx
80103d8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103d91:	89 14 24             	mov    %edx,(%esp)
80103d94:	e8 17 e6 ff ff       	call   801023b0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103d99:	8b 53 04             	mov    0x4(%ebx),%edx
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103d9c:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103da3:	89 14 24             	mov    %edx,(%esp)
80103da6:	e8 c5 2e 00 00       	call   80106c70 <freevm>
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        
        if(status != 0) {			//lab1 part 1b set status if status is not null
80103dab:	85 f6                	test   %esi,%esi
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
80103dad:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103db4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103dbb:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103dbf:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103dc6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        
        if(status != 0) {			//lab1 part 1b set status if status is not null
80103dcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103dd0:	74 05                	je     80103dd7 <wait+0xe7>
			*status = p->status;
80103dd2:	8b 53 7c             	mov    0x7c(%ebx),%edx
80103dd5:	89 16                	mov    %edx,(%esi)
		}
		
        release(&ptable.lock);
80103dd7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103dda:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103de1:	e8 5a 07 00 00       	call   80104540 <release>
        return pid;
80103de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103de9:	eb 96                	jmp    80103d81 <wait+0x91>
80103deb:	90                   	nop
80103dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103df0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait(0) to find out it exited.
void
exit(int status) // lab 1 part1a change to int status
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	56                   	push   %esi
80103df4:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
80103df5:	31 db                	xor    %ebx,%ebx
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait(0) to find out it exited.
void
exit(int status) // lab 1 part1a change to int status
{
80103df7:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80103dfa:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103e01:	3b 15 c4 a5 10 80    	cmp    0x8010a5c4,%edx
80103e07:	0f 84 18 01 00 00    	je     80103f25 <exit+0x135>
80103e0d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
80103e10:	8d 73 08             	lea    0x8(%ebx),%esi
80103e13:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103e17:	85 c0                	test   %eax,%eax
80103e19:	74 1d                	je     80103e38 <exit+0x48>
      fileclose(proc->ofile[fd]);
80103e1b:	89 04 24             	mov    %eax,(%esp)
80103e1e:	e8 3d d2 ff ff       	call   80101060 <fileclose>
      proc->ofile[fd] = 0;
80103e23:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e29:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80103e30:	00 
80103e31:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103e38:	83 c3 01             	add    $0x1,%ebx
80103e3b:	83 fb 10             	cmp    $0x10,%ebx
80103e3e:	75 d0                	jne    80103e10 <exit+0x20>
      proc->ofile[fd] = 0;
    }
  }

  // save exit status
  proc->status = status; //lab1 part1a return exit status to created variable
80103e40:	8b 45 08             	mov    0x8(%ebp),%eax
80103e43:	89 42 7c             	mov    %eax,0x7c(%edx)
  
  begin_op();
80103e46:	e8 65 ef ff ff       	call   80102db0 <begin_op>
  iput(proc->cwd);
80103e4b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e51:	8b 40 68             	mov    0x68(%eax),%eax
80103e54:	89 04 24             	mov    %eax,(%esp)
80103e57:	e8 d4 d5 ff ff       	call   80101430 <iput>
  end_op();
80103e5c:	e8 1f ee ff ff       	call   80102c80 <end_op>
  proc->cwd = 0;
80103e61:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e67:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80103e6e:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103e75:	e8 16 07 00 00       	call   80104590 <acquire>

  // Parent might be sleeping in wait(0).
  wakeup1(proc->parent);
80103e7a:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait(0) to find out it exited.
void
exit(int status) // lab 1 part1a change to int status
80103e81:	b9 d4 4e 11 80       	mov    $0x80114ed4,%ecx
80103e86:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait(0).
  wakeup1(proc->parent);
80103e8b:	8b 53 14             	mov    0x14(%ebx),%edx
80103e8e:	eb 0c                	jmp    80103e9c <exit+0xac>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e90:	05 84 00 00 00       	add    $0x84,%eax
80103e95:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103e9a:	74 1e                	je     80103eba <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
80103e9c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ea0:	75 ee                	jne    80103e90 <exit+0xa0>
80103ea2:	3b 50 20             	cmp    0x20(%eax),%edx
80103ea5:	75 e9                	jne    80103e90 <exit+0xa0>
      p->state = RUNNABLE;
80103ea7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eae:	05 84 00 00 00       	add    $0x84,%eax
80103eb3:	3d d4 4e 11 80       	cmp    $0x80114ed4,%eax
80103eb8:	75 e2                	jne    80103e9c <exit+0xac>
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103eba:	8b 35 c4 a5 10 80    	mov    0x8010a5c4,%esi
80103ec0:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
80103ec5:	eb 0f                	jmp    80103ed6 <exit+0xe6>
80103ec7:	90                   	nop

  // Parent might be sleeping in wait(0).
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ec8:	81 c2 84 00 00 00    	add    $0x84,%edx
80103ece:	81 fa d4 4e 11 80    	cmp    $0x80114ed4,%edx
80103ed4:	74 37                	je     80103f0d <exit+0x11d>
    if(p->parent == proc){
80103ed6:	3b 5a 14             	cmp    0x14(%edx),%ebx
80103ed9:	75 ed                	jne    80103ec8 <exit+0xd8>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103edb:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103edf:	89 72 14             	mov    %esi,0x14(%edx)
      if(p->state == ZOMBIE)
80103ee2:	75 e4                	jne    80103ec8 <exit+0xd8>
80103ee4:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103ee9:	eb 0e                	jmp    80103ef9 <exit+0x109>
80103eeb:	90                   	nop
80103eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ef0:	05 84 00 00 00       	add    $0x84,%eax
80103ef5:	39 c1                	cmp    %eax,%ecx
80103ef7:	74 cf                	je     80103ec8 <exit+0xd8>
    if(p->state == SLEEPING && p->chan == chan)
80103ef9:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103efd:	75 f1                	jne    80103ef0 <exit+0x100>
80103eff:	3b 70 20             	cmp    0x20(%eax),%esi
80103f02:	75 ec                	jne    80103ef0 <exit+0x100>
      p->state = RUNNABLE;
80103f04:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f0b:	eb e3                	jmp    80103ef0 <exit+0x100>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80103f0d:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103f14:	e8 47 fa ff ff       	call   80103960 <sched>
  panic("zombie exit");
80103f19:	c7 04 24 7e 77 10 80 	movl   $0x8010777e,(%esp)
80103f20:	e8 ab c4 ff ff       	call   801003d0 <panic>
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
80103f25:	c7 04 24 71 77 10 80 	movl   $0x80107771,(%esp)
80103f2c:	e8 9f c4 ff ff       	call   801003d0 <panic>
80103f31:	eb 0d                	jmp    80103f40 <allocproc>
80103f33:	90                   	nop
80103f34:	90                   	nop
80103f35:	90                   	nop
80103f36:	90                   	nop
80103f37:	90                   	nop
80103f38:	90                   	nop
80103f39:	90                   	nop
80103f3a:	90                   	nop
80103f3b:	90                   	nop
80103f3c:	90                   	nop
80103f3d:	90                   	nop
80103f3e:	90                   	nop
80103f3f:	90                   	nop

80103f40 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	53                   	push   %ebx
80103f44:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80103f47:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103f4e:	e8 3d 06 00 00       	call   80104590 <acquire>

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
80103f53:	8b 15 e0 2d 11 80    	mov    0x80112de0,%edx
80103f59:	85 d2                	test   %edx,%edx
80103f5b:	0f 84 b5 00 00 00    	je     80104016 <allocproc+0xd6>
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
80103f61:	bb 58 2e 11 80       	mov    $0x80112e58,%ebx
80103f66:	eb 12                	jmp    80103f7a <allocproc+0x3a>
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f68:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103f6e:	81 fb d4 4e 11 80    	cmp    $0x80114ed4,%ebx
80103f74:	0f 84 86 00 00 00    	je     80104000 <allocproc+0xc0>
    if(p->state == UNUSED)
80103f7a:	8b 43 0c             	mov    0xc(%ebx),%eax
80103f7d:	85 c0                	test   %eax,%eax
80103f7f:	75 e7                	jne    80103f68 <allocproc+0x28>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80103f81:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103f88:	a1 04 a0 10 80       	mov    0x8010a004,%eax
80103f8d:	89 43 10             	mov    %eax,0x10(%ebx)
80103f90:	83 c0 01             	add    $0x1,%eax
80103f93:	a3 04 a0 10 80       	mov    %eax,0x8010a004

  p->priority = 20; 	//lab1 part2 sceduling - set default priority to lowest priority
80103f98:	c7 83 80 00 00 00 14 	movl   $0x14,0x80(%ebx)
80103f9f:	00 00 00 

  release(&ptable.lock);
80103fa2:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103fa9:	e8 92 05 00 00       	call   80104540 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103fae:	e8 ad e3 ff ff       	call   80102360 <kalloc>
80103fb3:	85 c0                	test   %eax,%eax
80103fb5:	89 43 08             	mov    %eax,0x8(%ebx)
80103fb8:	74 66                	je     80104020 <allocproc+0xe0>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103fba:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  p->tf = (struct trapframe*)sp;
80103fc0:	89 53 18             	mov    %edx,0x18(%ebx)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103fc3:	c7 80 b0 0f 00 00 70 	movl   $0x80105970,0xfb0(%eax)
80103fca:	59 10 80 

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103fcd:	05 9c 0f 00 00       	add    $0xf9c,%eax
80103fd2:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103fd5:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80103fdc:	00 
80103fdd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103fe4:	00 
80103fe5:	89 04 24             	mov    %eax,(%esp)
80103fe8:	e8 43 06 00 00       	call   80104630 <memset>
  p->context->eip = (uint)forkret;
80103fed:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103ff0:	c7 40 10 10 39 10 80 	movl   $0x80103910,0x10(%eax)

  return p;
}
80103ff7:	89 d8                	mov    %ebx,%eax
80103ff9:	83 c4 14             	add    $0x14,%esp
80103ffc:	5b                   	pop    %ebx
80103ffd:	5d                   	pop    %ebp
80103ffe:	c3                   	ret    
80103fff:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80104000:	31 db                	xor    %ebx,%ebx
80104002:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80104009:	e8 32 05 00 00       	call   80104540 <release>
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
8010400e:	89 d8                	mov    %ebx,%eax
80104010:	83 c4 14             	add    $0x14,%esp
80104013:	5b                   	pop    %ebx
80104014:	5d                   	pop    %ebp
80104015:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;
80104016:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
8010401b:	e9 61 ff ff ff       	jmp    80103f81 <allocproc+0x41>

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80104020:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104027:	31 db                	xor    %ebx,%ebx
    return 0;
80104029:	eb cc                	jmp    80103ff7 <allocproc+0xb7>
8010402b:	90                   	nop
8010402c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104030 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	57                   	push   %edi
80104034:	56                   	push   %esi
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
80104035:	be ff ff ff ff       	mov    $0xffffffff,%esi
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
8010403a:	53                   	push   %ebx
8010403b:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
8010403e:	e8 fd fe ff ff       	call   80103f40 <allocproc>
80104043:	85 c0                	test   %eax,%eax
80104045:	89 c3                	mov    %eax,%ebx
80104047:	0f 84 d6 00 00 00    	je     80104123 <fork+0xf3>
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
8010404d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104053:	8b 10                	mov    (%eax),%edx
80104055:	89 54 24 04          	mov    %edx,0x4(%esp)
80104059:	8b 40 04             	mov    0x4(%eax),%eax
8010405c:	89 04 24             	mov    %eax,(%esp)
8010405f:	e8 8c 2c 00 00       	call   80106cf0 <copyuvm>
80104064:	85 c0                	test   %eax,%eax
80104066:	89 43 04             	mov    %eax,0x4(%ebx)
80104069:	0f 84 be 00 00 00    	je     8010412d <fork+0xfd>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
8010406f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *np->tf = *proc->tf;
80104075:	b9 13 00 00 00       	mov    $0x13,%ecx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
8010407a:	8b 00                	mov    (%eax),%eax
8010407c:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
8010407e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104084:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80104087:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010408e:	8b 43 18             	mov    0x18(%ebx),%eax
80104091:	8b 72 18             	mov    0x18(%edx),%esi
80104094:	89 c7                	mov    %eax,%edi
80104096:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104098:	31 f6                	xor    %esi,%esi
8010409a:	8b 43 18             	mov    0x18(%ebx),%eax
8010409d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
801040a4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801040ab:	90                   	nop
801040ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
801040b0:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
801040b4:	85 c0                	test   %eax,%eax
801040b6:	74 13                	je     801040cb <fork+0x9b>
      np->ofile[i] = filedup(proc->ofile[i]);
801040b8:	89 04 24             	mov    %eax,(%esp)
801040bb:	e8 d0 ce ff ff       	call   80100f90 <filedup>
801040c0:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
801040c4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801040cb:	83 c6 01             	add    $0x1,%esi
801040ce:	83 fe 10             	cmp    $0x10,%esi
801040d1:	75 dd                	jne    801040b0 <fork+0x80>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801040d3:	8b 42 68             	mov    0x68(%edx),%eax
801040d6:	89 04 24             	mov    %eax,(%esp)
801040d9:	e8 b2 d0 ff ff       	call   80101190 <idup>
801040de:	89 43 68             	mov    %eax,0x68(%ebx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
801040e1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801040e7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801040ee:	00 
801040ef:	83 c0 6c             	add    $0x6c,%eax
801040f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801040f6:	8d 43 6c             	lea    0x6c(%ebx),%eax
801040f9:	89 04 24             	mov    %eax,(%esp)
801040fc:	e8 1f 07 00 00       	call   80104820 <safestrcpy>

  pid = np->pid;
80104101:	8b 73 10             	mov    0x10(%ebx),%esi

  acquire(&ptable.lock);
80104104:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010410b:	e8 80 04 00 00       	call   80104590 <acquire>

  np->state = RUNNABLE;
80104110:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80104117:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
8010411e:	e8 1d 04 00 00       	call   80104540 <release>

  return pid;
}
80104123:	83 c4 1c             	add    $0x1c,%esp
80104126:	89 f0                	mov    %esi,%eax
80104128:	5b                   	pop    %ebx
80104129:	5e                   	pop    %esi
8010412a:	5f                   	pop    %edi
8010412b:	5d                   	pop    %ebp
8010412c:	c3                   	ret    
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
8010412d:	8b 43 08             	mov    0x8(%ebx),%eax
80104130:	89 04 24             	mov    %eax,(%esp)
80104133:	e8 78 e2 ff ff       	call   801023b0 <kfree>
    np->kstack = 0;
80104138:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
8010413f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104146:	eb db                	jmp    80104123 <fork+0xf3>
80104148:	90                   	nop
80104149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104150 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	83 ec 18             	sub    $0x18,%esp
  uint sz;

  sz = proc->sz;
80104156:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
8010415d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint sz;

  sz = proc->sz;
80104160:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80104162:	83 f9 00             	cmp    $0x0,%ecx
80104165:	7f 19                	jg     80104180 <growproc+0x30>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80104167:	75 39                	jne    801041a2 <growproc+0x52>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
80104169:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
8010416b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104171:	89 04 24             	mov    %eax,(%esp)
80104174:	e8 27 2e 00 00       	call   80106fa0 <switchuvm>
80104179:	31 c0                	xor    %eax,%eax
  return 0;
}
8010417b:	c9                   	leave  
8010417c:	c3                   	ret    
8010417d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104180:	01 c1                	add    %eax,%ecx
80104182:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80104186:	89 44 24 04          	mov    %eax,0x4(%esp)
8010418a:	8b 42 04             	mov    0x4(%edx),%eax
8010418d:	89 04 24             	mov    %eax,(%esp)
80104190:	e8 2b 2c 00 00       	call   80106dc0 <allocuvm>
80104195:	85 c0                	test   %eax,%eax
80104197:	74 27                	je     801041c0 <growproc+0x70>
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104199:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801041a0:	eb c7                	jmp    80104169 <growproc+0x19>
801041a2:	01 c1                	add    %eax,%ecx
801041a4:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801041a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801041ac:	8b 42 04             	mov    0x4(%edx),%eax
801041af:	89 04 24             	mov    %eax,(%esp)
801041b2:	e8 19 2a 00 00       	call   80106bd0 <deallocuvm>
801041b7:	85 c0                	test   %eax,%eax
801041b9:	75 de                	jne    80104199 <growproc+0x49>
801041bb:	90                   	nop
801041bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
801041c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041c5:	c9                   	leave  
801041c6:	c3                   	ret    
801041c7:	89 f6                	mov    %esi,%esi
801041c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041d0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	53                   	push   %ebx
801041d4:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801041d7:	e8 64 fd ff ff       	call   80103f40 <allocproc>
801041dc:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801041de:	a3 c4 a5 10 80       	mov    %eax,0x8010a5c4
  if((p->pgdir = setupkvm()) == 0)
801041e3:	e8 88 28 00 00       	call   80106a70 <setupkvm>
801041e8:	85 c0                	test   %eax,%eax
801041ea:	89 43 04             	mov    %eax,0x4(%ebx)
801041ed:	0f 84 ce 00 00 00    	je     801042c1 <userinit+0xf1>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801041f3:	89 04 24             	mov    %eax,(%esp)
801041f6:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
801041fd:	00 
801041fe:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
80104205:	80 
80104206:	e8 35 29 00 00       	call   80106b40 <inituvm>
  p->sz = PGSIZE;
8010420b:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104211:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80104218:	00 
80104219:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104220:	00 
80104221:	8b 43 18             	mov    0x18(%ebx),%eax
80104224:	89 04 24             	mov    %eax,(%esp)
80104227:	e8 04 04 00 00       	call   80104630 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010422c:	8b 43 18             	mov    0x18(%ebx),%eax
8010422f:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104235:	8b 43 18             	mov    0x18(%ebx),%eax
80104238:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
8010423e:	8b 43 18             	mov    0x18(%ebx),%eax
80104241:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104245:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104249:	8b 43 18             	mov    0x18(%ebx),%eax
8010424c:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104250:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104254:	8b 43 18             	mov    0x18(%ebx),%eax
80104257:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
8010425e:	8b 43 18             	mov    0x18(%ebx),%eax
80104261:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104268:	8b 43 18             	mov    0x18(%ebx),%eax
8010426b:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104272:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104275:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
8010427c:	00 
8010427d:	c7 44 24 04 a3 77 10 	movl   $0x801077a3,0x4(%esp)
80104284:	80 
80104285:	89 04 24             	mov    %eax,(%esp)
80104288:	e8 93 05 00 00       	call   80104820 <safestrcpy>
  p->cwd = namei("/");
8010428d:	c7 04 24 ac 77 10 80 	movl   $0x801077ac,(%esp)
80104294:	e8 27 dc ff ff       	call   80101ec0 <namei>
80104299:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
8010429c:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801042a3:	e8 e8 02 00 00       	call   80104590 <acquire>

  p->state = RUNNABLE;
801042a8:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
801042af:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801042b6:	e8 85 02 00 00       	call   80104540 <release>
}
801042bb:	83 c4 14             	add    $0x14,%esp
801042be:	5b                   	pop    %ebx
801042bf:	5d                   	pop    %ebp
801042c0:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801042c1:	c7 04 24 8a 77 10 80 	movl   $0x8010778a,(%esp)
801042c8:	e8 03 c1 ff ff       	call   801003d0 <panic>
801042cd:	8d 76 00             	lea    0x0(%esi),%esi

801042d0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801042d6:	c7 44 24 04 ae 77 10 	movl   $0x801077ae,0x4(%esp)
801042dd:	80 
801042de:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801042e5:	e8 16 01 00 00       	call   80104400 <initlock>
}
801042ea:	c9                   	leave  
801042eb:	c3                   	ret    
801042ec:	00 00                	add    %al,(%eax)
	...

801042f0 <holdingsleep>:
  release(&lk->lk);
}

int
holdingsleep(struct sleeplock *lk)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	83 ec 18             	sub    $0x18,%esp
801042f6:	89 75 fc             	mov    %esi,-0x4(%ebp)
801042f9:	8b 75 08             	mov    0x8(%ebp),%esi
801042fc:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  int r;
  
  acquire(&lk->lk);
801042ff:	8d 5e 04             	lea    0x4(%esi),%ebx
80104302:	89 1c 24             	mov    %ebx,(%esp)
80104305:	e8 86 02 00 00       	call   80104590 <acquire>
  r = lk->locked;
8010430a:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
8010430c:	89 1c 24             	mov    %ebx,(%esp)
8010430f:	e8 2c 02 00 00       	call   80104540 <release>
  return r;
}
80104314:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104317:	89 f0                	mov    %esi,%eax
80104319:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010431c:	89 ec                	mov    %ebp,%esp
8010431e:	5d                   	pop    %ebp
8010431f:	c3                   	ret    

80104320 <releasesleep>:
  release(&lk->lk);
}

void
releasesleep(struct sleeplock *lk)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	83 ec 18             	sub    $0x18,%esp
80104326:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104329:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010432c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
8010432f:	8d 73 04             	lea    0x4(%ebx),%esi
80104332:	89 34 24             	mov    %esi,(%esp)
80104335:	e8 56 02 00 00       	call   80104590 <acquire>
  lk->locked = 0;
8010433a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104340:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104347:	89 1c 24             	mov    %ebx,(%esp)
8010434a:	e8 51 f5 ff ff       	call   801038a0 <wakeup>
  release(&lk->lk);
}
8010434f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104352:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104355:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104358:	89 ec                	mov    %ebp,%esp
8010435a:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
8010435b:	e9 e0 01 00 00       	jmp    80104540 <release>

80104360 <acquiresleep>:
  lk->pid = 0;
}

void
acquiresleep(struct sleeplock *lk)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	56                   	push   %esi
80104364:	53                   	push   %ebx
80104365:	83 ec 10             	sub    $0x10,%esp
80104368:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010436b:	8d 73 04             	lea    0x4(%ebx),%esi
8010436e:	89 34 24             	mov    %esi,(%esp)
80104371:	e8 1a 02 00 00       	call   80104590 <acquire>
  while (lk->locked) {
80104376:	8b 13                	mov    (%ebx),%edx
80104378:	85 d2                	test   %edx,%edx
8010437a:	74 16                	je     80104392 <acquiresleep+0x32>
8010437c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104380:	89 74 24 04          	mov    %esi,0x4(%esp)
80104384:	89 1c 24             	mov    %ebx,(%esp)
80104387:	e8 74 f6 ff ff       	call   80103a00 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010438c:	8b 03                	mov    (%ebx),%eax
8010438e:	85 c0                	test   %eax,%eax
80104390:	75 ee                	jne    80104380 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104392:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
80104398:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010439e:	8b 40 10             	mov    0x10(%eax),%eax
801043a1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801043a4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043a7:	83 c4 10             	add    $0x10,%esp
801043aa:	5b                   	pop    %ebx
801043ab:	5e                   	pop    %esi
801043ac:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = proc->pid;
  release(&lk->lk);
801043ad:	e9 8e 01 00 00       	jmp    80104540 <release>
801043b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043c0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	53                   	push   %ebx
801043c4:	83 ec 14             	sub    $0x14,%esp
801043c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801043ca:	c7 44 24 04 f8 77 10 	movl   $0x801077f8,0x4(%esp)
801043d1:	80 
801043d2:	8d 43 04             	lea    0x4(%ebx),%eax
801043d5:	89 04 24             	mov    %eax,(%esp)
801043d8:	e8 23 00 00 00       	call   80104400 <initlock>
  lk->name = name;
801043dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801043e0:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043e6:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801043ed:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801043f0:	83 c4 14             	add    $0x14,%esp
801043f3:	5b                   	pop    %ebx
801043f4:	5d                   	pop    %ebp
801043f5:	c3                   	ret    
	...

80104400 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104406:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104409:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010440f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104412:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104419:	5d                   	pop    %ebp
8010441a:	c3                   	ret    
8010441b:	90                   	nop
8010441c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104420 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104420:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104421:	31 c0                	xor    %eax,%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104423:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104425:	8b 55 08             	mov    0x8(%ebp),%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104428:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010442b:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010442c:	83 ea 08             	sub    $0x8,%edx
8010442f:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104430:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104436:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010443c:	77 1a                	ja     80104458 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010443e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104441:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104444:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104447:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104449:	83 f8 0a             	cmp    $0xa,%eax
8010444c:	75 e2                	jne    80104430 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010444e:	5b                   	pop    %ebx
8010444f:	5d                   	pop    %ebp
80104450:	c3                   	ret    
80104451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104458:	83 f8 09             	cmp    $0x9,%eax
8010445b:	7f f1                	jg     8010444e <getcallerpcs+0x2e>
8010445d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104460:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104467:	83 c0 01             	add    $0x1,%eax
8010446a:	83 f8 0a             	cmp    $0xa,%eax
8010446d:	75 f1                	jne    80104460 <getcallerpcs+0x40>
    pcs[i] = 0;
}
8010446f:	5b                   	pop    %ebx
80104470:	5d                   	pop    %ebp
80104471:	c3                   	ret    
80104472:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104480 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104480:	55                   	push   %ebp
  return lock->locked && lock->cpu == cpu;
80104481:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104483:	89 e5                	mov    %esp,%ebp
80104485:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104488:	8b 0a                	mov    (%edx),%ecx
8010448a:	85 c9                	test   %ecx,%ecx
8010448c:	74 10                	je     8010449e <holding+0x1e>
8010448e:	8b 42 08             	mov    0x8(%edx),%eax
80104491:	65 3b 05 00 00 00 00 	cmp    %gs:0x0,%eax
80104498:	0f 94 c0             	sete   %al
8010449b:	0f b6 c0             	movzbl %al,%eax
}
8010449e:	5d                   	pop    %ebp
8010449f:	c3                   	ret    

801044a0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044a3:	9c                   	pushf  
801044a4:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
801044a5:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
801044a6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801044ac:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801044b2:	85 d2                	test   %edx,%edx
801044b4:	75 18                	jne    801044ce <pushcli+0x2e>
    cpu->intena = eflags & FL_IF;
801044b6:	81 e1 00 02 00 00    	and    $0x200,%ecx
801044bc:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
801044c2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801044c8:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  cpu->ncli += 1;
801044ce:	83 c2 01             	add    $0x1,%edx
801044d1:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
}
801044d7:	5d                   	pop    %ebp
801044d8:	c3                   	ret    
801044d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044e0 <popcli>:

void
popcli(void)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044e6:	9c                   	pushf  
801044e7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801044e8:	f6 c4 02             	test   $0x2,%ah
801044eb:	75 43                	jne    80104530 <popcli+0x50>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
801044ed:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801044f4:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801044fa:	83 e8 01             	sub    $0x1,%eax
801044fd:	85 c0                	test   %eax,%eax
801044ff:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
80104505:	78 1d                	js     80104524 <popcli+0x44>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
80104507:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010450d:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104513:	85 d2                	test   %edx,%edx
80104515:	75 0b                	jne    80104522 <popcli+0x42>
80104517:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010451d:	85 c0                	test   %eax,%eax
8010451f:	74 01                	je     80104522 <popcli+0x42>
}

static inline void
sti(void)
{
  asm volatile("sti");
80104521:	fb                   	sti    
    sti();
}
80104522:	c9                   	leave  
80104523:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
    panic("popcli");
80104524:	c7 04 24 1a 78 10 80 	movl   $0x8010781a,(%esp)
8010452b:	e8 a0 be ff ff       	call   801003d0 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80104530:	c7 04 24 03 78 10 80 	movl   $0x80107803,(%esp)
80104537:	e8 94 be ff ff       	call   801003d0 <panic>
8010453c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104540 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	83 ec 18             	sub    $0x18,%esp
80104546:	8b 45 08             	mov    0x8(%ebp),%eax

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104549:	8b 08                	mov    (%eax),%ecx
8010454b:	85 c9                	test   %ecx,%ecx
8010454d:	74 0c                	je     8010455b <release+0x1b>
8010454f:	8b 50 08             	mov    0x8(%eax),%edx
80104552:	65 3b 15 00 00 00 00 	cmp    %gs:0x0,%edx
80104559:	74 0d                	je     80104568 <release+0x28>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
8010455b:	c7 04 24 21 78 10 80 	movl   $0x80107821,(%esp)
80104562:	e8 69 be ff ff       	call   801003d0 <panic>
80104567:	90                   	nop

  lk->pcs[0] = 0;
80104568:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
8010456f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104576:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010457b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
}
80104581:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80104582:	e9 59 ff ff ff       	jmp    801044e0 <popcli>
80104587:	89 f6                	mov    %esi,%esi
80104589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104590 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104596:	9c                   	pushf  
80104597:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104598:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
80104599:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010459f:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801045a5:	85 d2                	test   %edx,%edx
801045a7:	75 18                	jne    801045c1 <acquire+0x31>
    cpu->intena = eflags & FL_IF;
801045a9:	81 e1 00 02 00 00    	and    $0x200,%ecx
801045af:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
801045b5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801045bb:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  cpu->ncli += 1;
801045c1:	83 c2 01             	add    $0x1,%edx
801045c4:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
801045ca:	8b 55 08             	mov    0x8(%ebp),%edx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
801045cd:	8b 02                	mov    (%edx),%eax
801045cf:	85 c0                	test   %eax,%eax
801045d1:	74 0c                	je     801045df <acquire+0x4f>
801045d3:	8b 42 08             	mov    0x8(%edx),%eax
801045d6:	65 3b 05 00 00 00 00 	cmp    %gs:0x0,%eax
801045dd:	74 41                	je     80104620 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801045df:	b9 01 00 00 00       	mov    $0x1,%ecx
801045e4:	eb 05                	jmp    801045eb <acquire+0x5b>
801045e6:	66 90                	xchg   %ax,%ax
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801045e8:	8b 55 08             	mov    0x8(%ebp),%edx
801045eb:	89 c8                	mov    %ecx,%eax
801045ed:	f0 87 02             	lock xchg %eax,(%edx)
801045f0:	85 c0                	test   %eax,%eax
801045f2:	75 f4                	jne    801045e8 <acquire+0x58>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801045f4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
801045f9:	8b 45 08             	mov    0x8(%ebp),%eax
801045fc:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104603:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104606:	8b 45 08             	mov    0x8(%ebp),%eax
80104609:	83 c0 0c             	add    $0xc,%eax
8010460c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104610:	8d 45 08             	lea    0x8(%ebp),%eax
80104613:	89 04 24             	mov    %eax,(%esp)
80104616:	e8 05 fe ff ff       	call   80104420 <getcallerpcs>
}
8010461b:	c9                   	leave  
8010461c:	c3                   	ret    
8010461d:	8d 76 00             	lea    0x0(%esi),%esi
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104620:	c7 04 24 29 78 10 80 	movl   $0x80107829,(%esp)
80104627:	e8 a4 bd ff ff       	call   801003d0 <panic>
8010462c:	00 00                	add    %al,(%eax)
	...

80104630 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	83 ec 08             	sub    $0x8,%esp
80104636:	8b 55 08             	mov    0x8(%ebp),%edx
80104639:	89 1c 24             	mov    %ebx,(%esp)
8010463c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010463f:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104643:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104646:	f6 c2 03             	test   $0x3,%dl
80104649:	75 05                	jne    80104650 <memset+0x20>
8010464b:	f6 c1 03             	test   $0x3,%cl
8010464e:	74 18                	je     80104668 <memset+0x38>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104650:	89 d7                	mov    %edx,%edi
80104652:	fc                   	cld    
80104653:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104655:	89 d0                	mov    %edx,%eax
80104657:	8b 1c 24             	mov    (%esp),%ebx
8010465a:	8b 7c 24 04          	mov    0x4(%esp),%edi
8010465e:	89 ec                	mov    %ebp,%esp
80104660:	5d                   	pop    %ebp
80104661:	c3                   	ret    
80104662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104668:	0f b6 f8             	movzbl %al,%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010466b:	89 f8                	mov    %edi,%eax
8010466d:	89 fb                	mov    %edi,%ebx
8010466f:	c1 e0 18             	shl    $0x18,%eax
80104672:	c1 e3 10             	shl    $0x10,%ebx
80104675:	09 d8                	or     %ebx,%eax
80104677:	09 f8                	or     %edi,%eax
80104679:	c1 e7 08             	shl    $0x8,%edi
8010467c:	09 f8                	or     %edi,%eax
8010467e:	89 d7                	mov    %edx,%edi
80104680:	c1 e9 02             	shr    $0x2,%ecx
80104683:	fc                   	cld    
80104684:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104686:	89 d0                	mov    %edx,%eax
80104688:	8b 1c 24             	mov    (%esp),%ebx
8010468b:	8b 7c 24 04          	mov    0x4(%esp),%edi
8010468f:	89 ec                	mov    %ebp,%esp
80104691:	5d                   	pop    %ebp
80104692:	c3                   	ret    
80104693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046a0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	8b 55 10             	mov    0x10(%ebp),%edx
801046a6:	57                   	push   %edi
801046a7:	8b 7d 0c             	mov    0xc(%ebp),%edi
801046aa:	56                   	push   %esi
801046ab:	8b 75 08             	mov    0x8(%ebp),%esi
801046ae:	53                   	push   %ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046af:	85 d2                	test   %edx,%edx
801046b1:	74 2d                	je     801046e0 <memcmp+0x40>
    if(*s1 != *s2)
801046b3:	0f b6 1e             	movzbl (%esi),%ebx
801046b6:	0f b6 0f             	movzbl (%edi),%ecx
801046b9:	38 cb                	cmp    %cl,%bl
801046bb:	75 2b                	jne    801046e8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046bd:	83 ea 01             	sub    $0x1,%edx
801046c0:	31 c0                	xor    %eax,%eax
801046c2:	eb 18                	jmp    801046dc <memcmp+0x3c>
801046c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s1 != *s2)
801046c8:	0f b6 5c 06 01       	movzbl 0x1(%esi,%eax,1),%ebx
801046cd:	83 ea 01             	sub    $0x1,%edx
801046d0:	0f b6 4c 07 01       	movzbl 0x1(%edi,%eax,1),%ecx
801046d5:	83 c0 01             	add    $0x1,%eax
801046d8:	38 cb                	cmp    %cl,%bl
801046da:	75 0c                	jne    801046e8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046dc:	85 d2                	test   %edx,%edx
801046de:	75 e8                	jne    801046c8 <memcmp+0x28>
801046e0:	31 c0                	xor    %eax,%eax
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801046e2:	5b                   	pop    %ebx
801046e3:	5e                   	pop    %esi
801046e4:	5f                   	pop    %edi
801046e5:	5d                   	pop    %ebp
801046e6:	c3                   	ret    
801046e7:	90                   	nop

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801046e8:	0f b6 c3             	movzbl %bl,%eax
801046eb:	0f b6 c9             	movzbl %cl,%ecx
801046ee:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
801046f0:	5b                   	pop    %ebx
801046f1:	5e                   	pop    %esi
801046f2:	5f                   	pop    %edi
801046f3:	5d                   	pop    %ebp
801046f4:	c3                   	ret    
801046f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104700 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	57                   	push   %edi
80104704:	8b 45 08             	mov    0x8(%ebp),%eax
80104707:	56                   	push   %esi
80104708:	8b 75 0c             	mov    0xc(%ebp),%esi
8010470b:	53                   	push   %ebx
8010470c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010470f:	39 c6                	cmp    %eax,%esi
80104711:	73 2d                	jae    80104740 <memmove+0x40>
80104713:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
80104716:	39 f8                	cmp    %edi,%eax
80104718:	73 26                	jae    80104740 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
8010471a:	85 db                	test   %ebx,%ebx
8010471c:	74 1d                	je     8010473b <memmove+0x3b>

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
8010471e:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80104721:	31 d2                	xor    %edx,%edx
80104723:	90                   	nop
80104724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
      *--d = *--s;
80104728:	0f b6 4c 17 ff       	movzbl -0x1(%edi,%edx,1),%ecx
8010472d:	88 4c 16 ff          	mov    %cl,-0x1(%esi,%edx,1)
80104731:	83 ea 01             	sub    $0x1,%edx
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104734:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80104737:	85 c9                	test   %ecx,%ecx
80104739:	75 ed                	jne    80104728 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010473b:	5b                   	pop    %ebx
8010473c:	5e                   	pop    %esi
8010473d:	5f                   	pop    %edi
8010473e:	5d                   	pop    %ebp
8010473f:	c3                   	ret    
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104740:	31 d2                	xor    %edx,%edx
      *--d = *--s;
  } else
    while(n-- > 0)
80104742:	85 db                	test   %ebx,%ebx
80104744:	74 f5                	je     8010473b <memmove+0x3b>
80104746:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104748:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
8010474c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
8010474f:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104752:	39 d3                	cmp    %edx,%ebx
80104754:	75 f2                	jne    80104748 <memmove+0x48>
      *d++ = *s++;

  return dst;
}
80104756:	5b                   	pop    %ebx
80104757:	5e                   	pop    %esi
80104758:	5f                   	pop    %edi
80104759:	5d                   	pop    %ebp
8010475a:	c3                   	ret    
8010475b:	90                   	nop
8010475c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104760 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104763:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104764:	e9 97 ff ff ff       	jmp    80104700 <memmove>
80104769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104770 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	57                   	push   %edi
80104774:	8b 7d 10             	mov    0x10(%ebp),%edi
80104777:	56                   	push   %esi
80104778:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010477b:	53                   	push   %ebx
8010477c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
8010477f:	85 ff                	test   %edi,%edi
80104781:	74 3d                	je     801047c0 <strncmp+0x50>
80104783:	0f b6 01             	movzbl (%ecx),%eax
80104786:	84 c0                	test   %al,%al
80104788:	75 18                	jne    801047a2 <strncmp+0x32>
8010478a:	eb 3c                	jmp    801047c8 <strncmp+0x58>
8010478c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104790:	83 ef 01             	sub    $0x1,%edi
80104793:	74 2b                	je     801047c0 <strncmp+0x50>
    n--, p++, q++;
80104795:	83 c1 01             	add    $0x1,%ecx
80104798:	83 c3 01             	add    $0x1,%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010479b:	0f b6 01             	movzbl (%ecx),%eax
8010479e:	84 c0                	test   %al,%al
801047a0:	74 26                	je     801047c8 <strncmp+0x58>
801047a2:	0f b6 33             	movzbl (%ebx),%esi
801047a5:	89 f2                	mov    %esi,%edx
801047a7:	38 d0                	cmp    %dl,%al
801047a9:	74 e5                	je     80104790 <strncmp+0x20>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801047ab:	81 e6 ff 00 00 00    	and    $0xff,%esi
801047b1:	0f b6 c0             	movzbl %al,%eax
801047b4:	29 f0                	sub    %esi,%eax
}
801047b6:	5b                   	pop    %ebx
801047b7:	5e                   	pop    %esi
801047b8:	5f                   	pop    %edi
801047b9:	5d                   	pop    %ebp
801047ba:	c3                   	ret    
801047bb:	90                   	nop
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801047c0:	31 c0                	xor    %eax,%eax
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801047c2:	5b                   	pop    %ebx
801047c3:	5e                   	pop    %esi
801047c4:	5f                   	pop    %edi
801047c5:	5d                   	pop    %ebp
801047c6:	c3                   	ret    
801047c7:	90                   	nop
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801047c8:	0f b6 33             	movzbl (%ebx),%esi
801047cb:	eb de                	jmp    801047ab <strncmp+0x3b>
801047cd:	8d 76 00             	lea    0x0(%esi),%esi

801047d0 <strncpy>:
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	8b 45 08             	mov    0x8(%ebp),%eax
801047d6:	56                   	push   %esi
801047d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047da:	53                   	push   %ebx
801047db:	8b 75 0c             	mov    0xc(%ebp),%esi
801047de:	89 c3                	mov    %eax,%ebx
801047e0:	eb 09                	jmp    801047eb <strncpy+0x1b>
801047e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801047e8:	83 c6 01             	add    $0x1,%esi
801047eb:	83 e9 01             	sub    $0x1,%ecx
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
801047ee:	8d 51 01             	lea    0x1(%ecx),%edx
{
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801047f1:	85 d2                	test   %edx,%edx
801047f3:	7e 0c                	jle    80104801 <strncpy+0x31>
801047f5:	0f b6 16             	movzbl (%esi),%edx
801047f8:	88 13                	mov    %dl,(%ebx)
801047fa:	83 c3 01             	add    $0x1,%ebx
801047fd:	84 d2                	test   %dl,%dl
801047ff:	75 e7                	jne    801047e8 <strncpy+0x18>
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
80104801:	31 d2                	xor    %edx,%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80104803:	85 c9                	test   %ecx,%ecx
80104805:	7e 0c                	jle    80104813 <strncpy+0x43>
80104807:	90                   	nop
    *s++ = 0;
80104808:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
8010480c:	83 c2 01             	add    $0x1,%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010480f:	39 ca                	cmp    %ecx,%edx
80104811:	75 f5                	jne    80104808 <strncpy+0x38>
    *s++ = 0;
  return os;
}
80104813:	5b                   	pop    %ebx
80104814:	5e                   	pop    %esi
80104815:	5d                   	pop    %ebp
80104816:	c3                   	ret    
80104817:	89 f6                	mov    %esi,%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104820 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	8b 55 10             	mov    0x10(%ebp),%edx
80104826:	56                   	push   %esi
80104827:	8b 45 08             	mov    0x8(%ebp),%eax
8010482a:	53                   	push   %ebx
8010482b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  if(n <= 0)
8010482e:	85 d2                	test   %edx,%edx
80104830:	7e 1f                	jle    80104851 <safestrcpy+0x31>
80104832:	89 c1                	mov    %eax,%ecx
80104834:	eb 05                	jmp    8010483b <safestrcpy+0x1b>
80104836:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104838:	83 c6 01             	add    $0x1,%esi
8010483b:	83 ea 01             	sub    $0x1,%edx
8010483e:	85 d2                	test   %edx,%edx
80104840:	7e 0c                	jle    8010484e <safestrcpy+0x2e>
80104842:	0f b6 1e             	movzbl (%esi),%ebx
80104845:	88 19                	mov    %bl,(%ecx)
80104847:	83 c1 01             	add    $0x1,%ecx
8010484a:	84 db                	test   %bl,%bl
8010484c:	75 ea                	jne    80104838 <safestrcpy+0x18>
    ;
  *s = 0;
8010484e:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104851:	5b                   	pop    %ebx
80104852:	5e                   	pop    %esi
80104853:	5d                   	pop    %ebp
80104854:	c3                   	ret    
80104855:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104860 <strlen>:

int
strlen(const char *s)
{
80104860:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104861:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104863:	89 e5                	mov    %esp,%ebp
80104865:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104868:	80 3a 00             	cmpb   $0x0,(%edx)
8010486b:	74 0c                	je     80104879 <strlen+0x19>
8010486d:	8d 76 00             	lea    0x0(%esi),%esi
80104870:	83 c0 01             	add    $0x1,%eax
80104873:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104877:	75 f7                	jne    80104870 <strlen+0x10>
    ;
  return n;
}
80104879:	5d                   	pop    %ebp
8010487a:	c3                   	ret    
	...

8010487c <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010487c:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104880:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104884:	55                   	push   %ebp
  pushl %ebx
80104885:	53                   	push   %ebx
  pushl %esi
80104886:	56                   	push   %esi
  pushl %edi
80104887:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104888:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
8010488a:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010488c:	5f                   	pop    %edi
  popl %esi
8010488d:	5e                   	pop    %esi
  popl %ebx
8010488e:	5b                   	pop    %ebx
  popl %ebp
8010488f:	5d                   	pop    %ebp
  ret
80104890:	c3                   	ret    
	...

801048a0 <fetchint>:

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801048a0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801048a7:	55                   	push   %ebp
801048a8:	89 e5                	mov    %esp,%ebp
801048aa:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
801048ad:	8b 12                	mov    (%edx),%edx
801048af:	39 c2                	cmp    %eax,%edx
801048b1:	77 0d                	ja     801048c0 <fetchint+0x20>
    return -1;
  *ip = *(int*)(addr);
  return 0;
801048b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801048b8:	5d                   	pop    %ebp
801048b9:	c3                   	ret    
801048ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801048c0:	8d 48 04             	lea    0x4(%eax),%ecx
801048c3:	39 ca                	cmp    %ecx,%edx
801048c5:	72 ec                	jb     801048b3 <fetchint+0x13>
    return -1;
  *ip = *(int*)(addr);
801048c7:	8b 10                	mov    (%eax),%edx
801048c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801048cc:	89 10                	mov    %edx,(%eax)
801048ce:	31 c0                	xor    %eax,%eax
  return 0;
}
801048d0:	5d                   	pop    %ebp
801048d1:	c3                   	ret    
801048d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048e0 <fetchstr>:
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
801048e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801048e6:	55                   	push   %ebp
801048e7:	89 e5                	mov    %esp,%ebp
801048e9:	8b 55 08             	mov    0x8(%ebp),%edx
801048ec:	53                   	push   %ebx
  char *s, *ep;

  if(addr >= proc->sz)
801048ed:	39 10                	cmp    %edx,(%eax)
801048ef:	77 0f                	ja     80104900 <fetchstr+0x20>
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801048f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(*s == 0)
      return s - *pp;
  return -1;
}
801048f6:	5b                   	pop    %ebx
801048f7:	5d                   	pop    %ebp
801048f8:	c3                   	ret    
801048f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  char *s, *ep;

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
80104900:	8b 45 0c             	mov    0xc(%ebp),%eax
80104903:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80104905:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010490b:	8b 18                	mov    (%eax),%ebx
  for(s = *pp; s < ep; s++)
8010490d:	39 da                	cmp    %ebx,%edx
8010490f:	73 e0                	jae    801048f1 <fetchstr+0x11>
    if(*s == 0)
80104911:	31 c0                	xor    %eax,%eax
80104913:	89 d1                	mov    %edx,%ecx
80104915:	80 3a 00             	cmpb   $0x0,(%edx)
80104918:	74 dc                	je     801048f6 <fetchstr+0x16>
8010491a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80104920:	83 c1 01             	add    $0x1,%ecx
80104923:	39 cb                	cmp    %ecx,%ebx
80104925:	76 ca                	jbe    801048f1 <fetchstr+0x11>
    if(*s == 0)
80104927:	80 39 00             	cmpb   $0x0,(%ecx)
8010492a:	75 f4                	jne    80104920 <fetchstr+0x40>
8010492c:	89 c8                	mov    %ecx,%eax
8010492e:	29 d0                	sub    %edx,%eax
80104930:	eb c4                	jmp    801048f6 <fetchstr+0x16>
80104932:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104940 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104940:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104946:	55                   	push   %ebp
80104947:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104949:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010494c:	8b 50 18             	mov    0x18(%eax),%edx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010494f:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104951:	8b 52 44             	mov    0x44(%edx),%edx
80104954:	8d 54 8a 04          	lea    0x4(%edx,%ecx,4),%edx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104958:	39 c2                	cmp    %eax,%edx
8010495a:	72 0c                	jb     80104968 <argint+0x28>
    return -1;
  *ip = *(int*)(addr);
8010495c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
80104961:	5d                   	pop    %ebp
80104962:	c3                   	ret    
80104963:	90                   	nop
80104964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104968:	8d 4a 04             	lea    0x4(%edx),%ecx
8010496b:	39 c8                	cmp    %ecx,%eax
8010496d:	72 ed                	jb     8010495c <argint+0x1c>
    return -1;
  *ip = *(int*)(addr);
8010496f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104972:	8b 12                	mov    (%edx),%edx
80104974:	89 10                	mov    %edx,(%eax)
80104976:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
80104978:	5d                   	pop    %ebp
80104979:	c3                   	ret    
8010497a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104980 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104980:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104986:	55                   	push   %ebp
80104987:	89 e5                	mov    %esp,%ebp
80104989:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010498a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010498d:	8b 50 18             	mov    0x18(%eax),%edx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104990:	8b 00                	mov    (%eax),%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104992:	8b 5d 10             	mov    0x10(%ebp),%ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104995:	8b 52 44             	mov    0x44(%edx),%edx
80104998:	8d 54 8a 04          	lea    0x4(%edx,%ecx,4),%edx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010499c:	39 c2                	cmp    %eax,%edx
8010499e:	73 07                	jae    801049a7 <argptr+0x27>
801049a0:	8d 4a 04             	lea    0x4(%edx),%ecx
801049a3:	39 c8                	cmp    %ecx,%eax
801049a5:	73 09                	jae    801049b0 <argptr+0x30>
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
801049a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049ac:	5b                   	pop    %ebx
801049ad:	5d                   	pop    %ebp
801049ae:	c3                   	ret    
801049af:	90                   	nop
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
801049b0:	85 db                	test   %ebx,%ebx
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
801049b2:	8b 12                	mov    (%edx),%edx
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
801049b4:	78 f1                	js     801049a7 <argptr+0x27>
801049b6:	39 c2                	cmp    %eax,%edx
801049b8:	73 ed                	jae    801049a7 <argptr+0x27>
801049ba:	8d 1c 1a             	lea    (%edx,%ebx,1),%ebx
801049bd:	39 c3                	cmp    %eax,%ebx
801049bf:	77 e6                	ja     801049a7 <argptr+0x27>
    return -1;
  *pp = (char*)i;
801049c1:	8b 45 0c             	mov    0xc(%ebp),%eax
801049c4:	89 10                	mov    %edx,(%eax)
801049c6:	31 c0                	xor    %eax,%eax
  return 0;
801049c8:	eb e2                	jmp    801049ac <argptr+0x2c>
801049ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049d0 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801049d6:	55                   	push   %ebp
801049d7:	89 e5                	mov    %esp,%ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801049d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801049dc:	8b 50 18             	mov    0x18(%eax),%edx
801049df:	8b 52 44             	mov    0x44(%edx),%edx
801049e2:	8d 4c 8a 04          	lea    0x4(%edx,%ecx,4),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801049e6:	8b 10                	mov    (%eax),%edx
801049e8:	39 d1                	cmp    %edx,%ecx
801049ea:	73 07                	jae    801049f3 <argstr+0x23>
801049ec:	8d 41 04             	lea    0x4(%ecx),%eax
801049ef:	39 c2                	cmp    %eax,%edx
801049f1:	73 0d                	jae    80104a00 <argstr+0x30>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801049f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
801049f8:	5d                   	pop    %ebp
801049f9:	c3                   	ret    
801049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
80104a00:	8b 09                	mov    (%ecx),%ecx
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
80104a02:	39 d1                	cmp    %edx,%ecx
80104a04:	73 ed                	jae    801049f3 <argstr+0x23>
    return -1;
  *pp = (char*)addr;
80104a06:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a09:	89 c8                	mov    %ecx,%eax
80104a0b:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104a0d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a14:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104a16:	39 d1                	cmp    %edx,%ecx
80104a18:	73 d9                	jae    801049f3 <argstr+0x23>
    if(*s == 0)
80104a1a:	80 39 00             	cmpb   $0x0,(%ecx)
80104a1d:	75 13                	jne    80104a32 <argstr+0x62>
80104a1f:	eb 1f                	jmp    80104a40 <argstr+0x70>
80104a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a28:	80 38 00             	cmpb   $0x0,(%eax)
80104a2b:	90                   	nop
80104a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a30:	74 0e                	je     80104a40 <argstr+0x70>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80104a32:	83 c0 01             	add    $0x1,%eax
80104a35:	39 c2                	cmp    %eax,%edx
80104a37:	77 ef                	ja     80104a28 <argstr+0x58>
80104a39:	eb b8                	jmp    801049f3 <argstr+0x23>
80104a3b:	90                   	nop
80104a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == 0)
      return s - *pp;
80104a40:	29 c8                	sub    %ecx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104a42:	5d                   	pop    %ebp
80104a43:	c3                   	ret    
80104a44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104a50 <syscall>:
[SYS_setpriority] sys_setpriority,	//lab 1 part2
};

void
syscall(void)
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	53                   	push   %ebx
80104a54:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
80104a57:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a5e:	8b 5a 18             	mov    0x18(%edx),%ebx
80104a61:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a64:	8d 48 ff             	lea    -0x1(%eax),%ecx
80104a67:	83 f9 17             	cmp    $0x17,%ecx
80104a6a:	77 1c                	ja     80104a88 <syscall+0x38>
80104a6c:	8b 0c 85 60 78 10 80 	mov    -0x7fef87a0(,%eax,4),%ecx
80104a73:	85 c9                	test   %ecx,%ecx
80104a75:	74 11                	je     80104a88 <syscall+0x38>
    proc->tf->eax = syscalls[num]();
80104a77:	ff d1                	call   *%ecx
80104a79:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
80104a7c:	83 c4 14             	add    $0x14,%esp
80104a7f:	5b                   	pop    %ebx
80104a80:	5d                   	pop    %ebp
80104a81:	c3                   	ret    
80104a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a88:	89 44 24 0c          	mov    %eax,0xc(%esp)
80104a8c:	8d 42 6c             	lea    0x6c(%edx),%eax
80104a8f:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a93:	8b 42 10             	mov    0x10(%edx),%eax
80104a96:	c7 04 24 31 78 10 80 	movl   $0x80107831,(%esp)
80104a9d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104aa1:	e8 ca bd ff ff       	call   80100870 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80104aa6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aac:	8b 40 18             	mov    0x18(%eax),%eax
80104aaf:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104ab6:	83 c4 14             	add    $0x14,%esp
80104ab9:	5b                   	pop    %ebx
80104aba:	5d                   	pop    %ebp
80104abb:	c3                   	ret    
80104abc:	00 00                	add    %al,(%eax)
	...

80104ac0 <sys_pipe>:
  return exec(path, argv);
}

int
sys_pipe(void)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104ac6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80104ac9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104acc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104acf:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80104ad6:	00 
80104ad7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104adb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ae2:	e8 99 fe ff ff       	call   80104980 <argptr>
80104ae7:	85 c0                	test   %eax,%eax
80104ae9:	79 15                	jns    80104b00 <sys_pipe+0x40>
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
80104aeb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80104af0:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104af3:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104af6:	89 ec                	mov    %ebp,%esp
80104af8:	5d                   	pop    %ebp
80104af9:	c3                   	ret    
80104afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80104b00:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104b03:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b07:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b0a:	89 04 24             	mov    %eax,(%esp)
80104b0d:	e8 0e eb ff ff       	call   80103620 <pipealloc>
80104b12:	85 c0                	test   %eax,%eax
80104b14:	78 d5                	js     80104aeb <sys_pipe+0x2b>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104b16:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80104b19:	31 c0                	xor    %eax,%eax
80104b1b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80104b28:	8b 5c 82 28          	mov    0x28(%edx,%eax,4),%ebx
80104b2c:	85 db                	test   %ebx,%ebx
80104b2e:	74 28                	je     80104b58 <sys_pipe+0x98>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104b30:	83 c0 01             	add    $0x1,%eax
80104b33:	83 f8 10             	cmp    $0x10,%eax
80104b36:	75 f0                	jne    80104b28 <sys_pipe+0x68>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
80104b38:	89 0c 24             	mov    %ecx,(%esp)
80104b3b:	e8 20 c5 ff ff       	call   80101060 <fileclose>
    fileclose(wf);
80104b40:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b43:	89 04 24             	mov    %eax,(%esp)
80104b46:	e8 15 c5 ff ff       	call   80101060 <fileclose>
80104b4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
80104b50:	eb 9e                	jmp    80104af0 <sys_pipe+0x30>
80104b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104b58:	8d 58 08             	lea    0x8(%eax),%ebx
80104b5b:	89 4c 9a 08          	mov    %ecx,0x8(%edx,%ebx,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104b5f:	8b 75 ec             	mov    -0x14(%ebp),%esi
80104b62:	31 d2                	xor    %edx,%edx
80104b64:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80104b6b:	90                   	nop
80104b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80104b70:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
80104b75:	74 19                	je     80104b90 <sys_pipe+0xd0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104b77:	83 c2 01             	add    $0x1,%edx
80104b7a:	83 fa 10             	cmp    $0x10,%edx
80104b7d:	75 f1                	jne    80104b70 <sys_pipe+0xb0>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
80104b7f:	c7 44 99 08 00 00 00 	movl   $0x0,0x8(%ecx,%ebx,4)
80104b86:	00 
80104b87:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80104b8a:	eb ac                	jmp    80104b38 <sys_pipe+0x78>
80104b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104b90:	89 74 91 28          	mov    %esi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80104b94:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80104b97:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80104b99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b9c:	89 50 04             	mov    %edx,0x4(%eax)
80104b9f:	31 c0                	xor    %eax,%eax
  return 0;
80104ba1:	e9 4a ff ff ff       	jmp    80104af0 <sys_pipe+0x30>
80104ba6:	8d 76 00             	lea    0x0(%esi),%esi
80104ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bb0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	81 ec b8 00 00 00    	sub    $0xb8,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104bb9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
80104bbc:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104bbf:	89 75 f8             	mov    %esi,-0x8(%ebp)
80104bc2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104bc5:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bc9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104bd0:	e8 fb fd ff ff       	call   801049d0 <argstr>
80104bd5:	85 c0                	test   %eax,%eax
80104bd7:	79 17                	jns    80104bf0 <sys_exec+0x40>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
80104bd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80104bde:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104be1:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104be4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104be7:	89 ec                	mov    %ebp,%esp
80104be9:	5d                   	pop    %ebp
80104bea:	c3                   	ret    
80104beb:	90                   	nop
80104bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104bf0:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104bf3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bf7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104bfe:	e8 3d fd ff ff       	call   80104940 <argint>
80104c03:	85 c0                	test   %eax,%eax
80104c05:	78 d2                	js     80104bd9 <sys_exec+0x29>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80104c07:	8d bd 5c ff ff ff    	lea    -0xa4(%ebp),%edi
80104c0d:	31 f6                	xor    %esi,%esi
80104c0f:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80104c16:	00 
80104c17:	31 db                	xor    %ebx,%ebx
80104c19:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104c20:	00 
80104c21:	89 3c 24             	mov    %edi,(%esp)
80104c24:	e8 07 fa ff ff       	call   80104630 <memset>
80104c29:	eb 22                	jmp    80104c4d <sys_exec+0x9d>
80104c2b:	90                   	nop
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80104c30:	8d 14 b7             	lea    (%edi,%esi,4),%edx
80104c33:	89 54 24 04          	mov    %edx,0x4(%esp)
80104c37:	89 04 24             	mov    %eax,(%esp)
80104c3a:	e8 a1 fc ff ff       	call   801048e0 <fetchstr>
80104c3f:	85 c0                	test   %eax,%eax
80104c41:	78 96                	js     80104bd9 <sys_exec+0x29>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80104c43:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80104c46:	83 fb 20             	cmp    $0x20,%ebx

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80104c49:	89 de                	mov    %ebx,%esi
    if(i >= NELEM(argv))
80104c4b:	74 8c                	je     80104bd9 <sys_exec+0x29>
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80104c4d:	8d 45 dc             	lea    -0x24(%ebp),%eax
80104c50:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c54:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax
80104c5b:	03 45 e0             	add    -0x20(%ebp),%eax
80104c5e:	89 04 24             	mov    %eax,(%esp)
80104c61:	e8 3a fc ff ff       	call   801048a0 <fetchint>
80104c66:	85 c0                	test   %eax,%eax
80104c68:	0f 88 6b ff ff ff    	js     80104bd9 <sys_exec+0x29>
      return -1;
    if(uarg == 0){
80104c6e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104c71:	85 c0                	test   %eax,%eax
80104c73:	75 bb                	jne    80104c30 <sys_exec+0x80>
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80104c75:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80104c78:	c7 84 9d 5c ff ff ff 	movl   $0x0,-0xa4(%ebp,%ebx,4)
80104c7f:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80104c83:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104c87:	89 04 24             	mov    %eax,(%esp)
80104c8a:	e8 51 bd ff ff       	call   801009e0 <exec>
80104c8f:	e9 4a ff ff ff       	jmp    80104bde <sys_exec+0x2e>
80104c94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ca0 <sys_chdir>:
  return 0;
}

int
sys_chdir(void)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	53                   	push   %ebx
80104ca4:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104ca7:	e8 04 e1 ff ff       	call   80102db0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80104cac:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104caf:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cb3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104cba:	e8 11 fd ff ff       	call   801049d0 <argstr>
80104cbf:	85 c0                	test   %eax,%eax
80104cc1:	78 5d                	js     80104d20 <sys_chdir+0x80>
80104cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cc6:	89 04 24             	mov    %eax,(%esp)
80104cc9:	e8 f2 d1 ff ff       	call   80101ec0 <namei>
80104cce:	85 c0                	test   %eax,%eax
80104cd0:	89 c3                	mov    %eax,%ebx
80104cd2:	74 4c                	je     80104d20 <sys_chdir+0x80>
    end_op();
    return -1;
  }
  ilock(ip);
80104cd4:	89 04 24             	mov    %eax,(%esp)
80104cd7:	e8 84 cf ff ff       	call   80101c60 <ilock>
  if(ip->type != T_DIR){
80104cdc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ce1:	75 35                	jne    80104d18 <sys_chdir+0x78>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104ce3:	89 1c 24             	mov    %ebx,(%esp)
80104ce6:	e8 05 cf ff ff       	call   80101bf0 <iunlock>
  iput(proc->cwd);
80104ceb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cf1:	8b 40 68             	mov    0x68(%eax),%eax
80104cf4:	89 04 24             	mov    %eax,(%esp)
80104cf7:	e8 34 c7 ff ff       	call   80101430 <iput>
  end_op();
80104cfc:	e8 7f df ff ff       	call   80102c80 <end_op>
  proc->cwd = ip;
80104d01:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d07:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
}
80104d0a:	83 c4 24             	add    $0x24,%esp
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
80104d0d:	31 c0                	xor    %eax,%eax
  return 0;
}
80104d0f:	5b                   	pop    %ebx
80104d10:	5d                   	pop    %ebp
80104d11:	c3                   	ret    
80104d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80104d18:	89 1c 24             	mov    %ebx,(%esp)
80104d1b:	e8 20 cf ff ff       	call   80101c40 <iunlockput>
    end_op();
80104d20:	e8 5b df ff ff       	call   80102c80 <end_op>
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
  return 0;
}
80104d25:	83 c4 24             	add    $0x24,%esp
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
80104d28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
  return 0;
}
80104d2d:	5b                   	pop    %ebx
80104d2e:	5d                   	pop    %ebp
80104d2f:	c3                   	ret    

80104d30 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	83 ec 58             	sub    $0x58,%esp
80104d36:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
80104d39:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104d3c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d3f:	8d 75 d6             	lea    -0x2a(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d42:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d45:	31 db                	xor    %ebx,%ebx
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d47:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104d4a:	89 d7                	mov    %edx,%edi
80104d4c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d4f:	89 74 24 04          	mov    %esi,0x4(%esp)
80104d53:	89 04 24             	mov    %eax,(%esp)
80104d56:	e8 45 d1 ff ff       	call   80101ea0 <nameiparent>
80104d5b:	85 c0                	test   %eax,%eax
80104d5d:	74 47                	je     80104da6 <create+0x76>
    return 0;
  ilock(dp);
80104d5f:	89 04 24             	mov    %eax,(%esp)
80104d62:	89 45 bc             	mov    %eax,-0x44(%ebp)
80104d65:	e8 f6 ce ff ff       	call   80101c60 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104d6a:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104d6d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104d70:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d74:	89 74 24 04          	mov    %esi,0x4(%esp)
80104d78:	89 14 24             	mov    %edx,(%esp)
80104d7b:	e8 00 cc ff ff       	call   80101980 <dirlookup>
80104d80:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104d83:	85 c0                	test   %eax,%eax
80104d85:	89 c3                	mov    %eax,%ebx
80104d87:	74 4f                	je     80104dd8 <create+0xa8>
    iunlockput(dp);
80104d89:	89 14 24             	mov    %edx,(%esp)
80104d8c:	e8 af ce ff ff       	call   80101c40 <iunlockput>
    ilock(ip);
80104d91:	89 1c 24             	mov    %ebx,(%esp)
80104d94:	e8 c7 ce ff ff       	call   80101c60 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104d99:	66 83 ff 02          	cmp    $0x2,%di
80104d9d:	75 19                	jne    80104db8 <create+0x88>
80104d9f:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104da4:	75 12                	jne    80104db8 <create+0x88>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104da6:	89 d8                	mov    %ebx,%eax
80104da8:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104dab:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104dae:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104db1:	89 ec                	mov    %ebp,%esp
80104db3:	5d                   	pop    %ebp
80104db4:	c3                   	ret    
80104db5:	8d 76 00             	lea    0x0(%esi),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104db8:	89 1c 24             	mov    %ebx,(%esp)
80104dbb:	31 db                	xor    %ebx,%ebx
80104dbd:	e8 7e ce ff ff       	call   80101c40 <iunlockput>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104dc2:	89 d8                	mov    %ebx,%eax
80104dc4:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104dc7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104dca:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104dcd:	89 ec                	mov    %ebp,%esp
80104dcf:	5d                   	pop    %ebp
80104dd0:	c3                   	ret    
80104dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104dd8:	0f bf c7             	movswl %di,%eax
80104ddb:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ddf:	8b 02                	mov    (%edx),%eax
80104de1:	89 55 bc             	mov    %edx,-0x44(%ebp)
80104de4:	89 04 24             	mov    %eax,(%esp)
80104de7:	e8 34 cd ff ff       	call   80101b20 <ialloc>
80104dec:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104def:	85 c0                	test   %eax,%eax
80104df1:	89 c3                	mov    %eax,%ebx
80104df3:	0f 84 cb 00 00 00    	je     80104ec4 <create+0x194>
    panic("create: ialloc");

  ilock(ip);
80104df9:	89 55 bc             	mov    %edx,-0x44(%ebp)
80104dfc:	89 04 24             	mov    %eax,(%esp)
80104dff:	e8 5c ce ff ff       	call   80101c60 <ilock>
  ip->major = major;
80104e04:	0f b7 45 c4          	movzwl -0x3c(%ebp),%eax
80104e08:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104e0c:	0f b7 4d c0          	movzwl -0x40(%ebp),%ecx
  ip->nlink = 1;
80104e10:	66 c7 43 56 01 00    	movw   $0x1,0x56(%ebx)
  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
80104e16:	66 89 4b 54          	mov    %cx,0x54(%ebx)
  ip->nlink = 1;
  iupdate(ip);
80104e1a:	89 1c 24             	mov    %ebx,(%esp)
80104e1d:	e8 8e c4 ff ff       	call   801012b0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104e22:	66 83 ff 01          	cmp    $0x1,%di
80104e26:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104e29:	74 3d                	je     80104e68 <create+0x138>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104e2b:	8b 43 04             	mov    0x4(%ebx),%eax
80104e2e:	89 14 24             	mov    %edx,(%esp)
80104e31:	89 55 bc             	mov    %edx,-0x44(%ebp)
80104e34:	89 74 24 04          	mov    %esi,0x4(%esp)
80104e38:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e3c:	e8 ef cb ff ff       	call   80101a30 <dirlink>
80104e41:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104e44:	85 c0                	test   %eax,%eax
80104e46:	0f 88 84 00 00 00    	js     80104ed0 <create+0x1a0>
    panic("create: dirlink");

  iunlockput(dp);
80104e4c:	89 14 24             	mov    %edx,(%esp)
80104e4f:	e8 ec cd ff ff       	call   80101c40 <iunlockput>

  return ip;
}
80104e54:	89 d8                	mov    %ebx,%eax
80104e56:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104e59:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104e5c:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104e5f:	89 ec                	mov    %ebp,%esp
80104e61:	5d                   	pop    %ebp
80104e62:	c3                   	ret    
80104e63:	90                   	nop
80104e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104e68:	66 83 42 56 01       	addw   $0x1,0x56(%edx)
    iupdate(dp);
80104e6d:	89 14 24             	mov    %edx,(%esp)
80104e70:	89 55 bc             	mov    %edx,-0x44(%ebp)
80104e73:	e8 38 c4 ff ff       	call   801012b0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104e78:	8b 43 04             	mov    0x4(%ebx),%eax
80104e7b:	c7 44 24 04 d4 78 10 	movl   $0x801078d4,0x4(%esp)
80104e82:	80 
80104e83:	89 1c 24             	mov    %ebx,(%esp)
80104e86:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e8a:	e8 a1 cb ff ff       	call   80101a30 <dirlink>
80104e8f:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104e92:	85 c0                	test   %eax,%eax
80104e94:	78 22                	js     80104eb8 <create+0x188>
80104e96:	8b 42 04             	mov    0x4(%edx),%eax
80104e99:	c7 44 24 04 d3 78 10 	movl   $0x801078d3,0x4(%esp)
80104ea0:	80 
80104ea1:	89 1c 24             	mov    %ebx,(%esp)
80104ea4:	89 44 24 08          	mov    %eax,0x8(%esp)
80104ea8:	e8 83 cb ff ff       	call   80101a30 <dirlink>
80104ead:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104eb0:	85 c0                	test   %eax,%eax
80104eb2:	0f 89 73 ff ff ff    	jns    80104e2b <create+0xfb>
      panic("create dots");
80104eb8:	c7 04 24 d6 78 10 80 	movl   $0x801078d6,(%esp)
80104ebf:	e8 0c b5 ff ff       	call   801003d0 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104ec4:	c7 04 24 c4 78 10 80 	movl   $0x801078c4,(%esp)
80104ecb:	e8 00 b5 ff ff       	call   801003d0 <panic>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104ed0:	c7 04 24 e2 78 10 80 	movl   $0x801078e2,(%esp)
80104ed7:	e8 f4 b4 ff ff       	call   801003d0 <panic>
80104edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ee0 <sys_mknod>:
  return 0;
}

int
sys_mknod(void)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80104ee6:	e8 c5 de ff ff       	call   80102db0 <begin_op>
  if((argstr(0, &path)) < 0 ||
80104eeb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104eee:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ef2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ef9:	e8 d2 fa ff ff       	call   801049d0 <argstr>
80104efe:	85 c0                	test   %eax,%eax
80104f00:	78 5e                	js     80104f60 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80104f02:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f05:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f09:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104f10:	e8 2b fa ff ff       	call   80104940 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80104f15:	85 c0                	test   %eax,%eax
80104f17:	78 47                	js     80104f60 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80104f19:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104f1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f20:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104f27:	e8 14 fa ff ff       	call   80104940 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80104f2c:	85 c0                	test   %eax,%eax
80104f2e:	78 30                	js     80104f60 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80104f30:	0f bf 45 ec          	movswl -0x14(%ebp),%eax
80104f34:	ba 03 00 00 00       	mov    $0x3,%edx
80104f39:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80104f3d:	89 04 24             	mov    %eax,(%esp)
80104f40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f43:	e8 e8 fd ff ff       	call   80104d30 <create>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80104f48:	85 c0                	test   %eax,%eax
80104f4a:	74 14                	je     80104f60 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
80104f4c:	89 04 24             	mov    %eax,(%esp)
80104f4f:	e8 ec cc ff ff       	call   80101c40 <iunlockput>
  end_op();
80104f54:	e8 27 dd ff ff       	call   80102c80 <end_op>
80104f59:	31 c0                	xor    %eax,%eax
  return 0;
}
80104f5b:	c9                   	leave  
80104f5c:	c3                   	ret    
80104f5d:	8d 76 00             	lea    0x0(%esi),%esi
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80104f60:	e8 1b dd ff ff       	call   80102c80 <end_op>
80104f65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80104f6a:	c9                   	leave  
80104f6b:	c3                   	ret    
80104f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f70 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104f76:	e8 35 de ff ff       	call   80102db0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80104f7b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f7e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f82:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104f89:	e8 42 fa ff ff       	call   801049d0 <argstr>
80104f8e:	85 c0                	test   %eax,%eax
80104f90:	78 2e                	js     80104fc0 <sys_mkdir+0x50>
80104f92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f95:	31 c9                	xor    %ecx,%ecx
80104f97:	ba 01 00 00 00       	mov    $0x1,%edx
80104f9c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104fa3:	e8 88 fd ff ff       	call   80104d30 <create>
80104fa8:	85 c0                	test   %eax,%eax
80104faa:	74 14                	je     80104fc0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104fac:	89 04 24             	mov    %eax,(%esp)
80104faf:	e8 8c cc ff ff       	call   80101c40 <iunlockput>
  end_op();
80104fb4:	e8 c7 dc ff ff       	call   80102c80 <end_op>
80104fb9:	31 c0                	xor    %eax,%eax
  return 0;
}
80104fbb:	c9                   	leave  
80104fbc:	c3                   	ret    
80104fbd:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80104fc0:	e8 bb dc ff ff       	call   80102c80 <end_op>
80104fc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80104fca:	c9                   	leave  
80104fcb:	c3                   	ret    
80104fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fd0 <sys_link>:
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	83 ec 48             	sub    $0x48,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fd6:	8d 45 e0             	lea    -0x20(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104fd9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104fdc:	89 75 f8             	mov    %esi,-0x8(%ebp)
80104fdf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fe2:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fe6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104fed:	e8 de f9 ff ff       	call   801049d0 <argstr>
80104ff2:	85 c0                	test   %eax,%eax
80104ff4:	79 12                	jns    80105008 <sys_link+0x38>
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104ff6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ffb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104ffe:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105001:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105004:	89 ec                	mov    %ebp,%esp
80105006:	5d                   	pop    %ebp
80105007:	c3                   	ret    
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105008:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010500b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010500f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105016:	e8 b5 f9 ff ff       	call   801049d0 <argstr>
8010501b:	85 c0                	test   %eax,%eax
8010501d:	78 d7                	js     80104ff6 <sys_link+0x26>
    return -1;

  begin_op();
8010501f:	e8 8c dd ff ff       	call   80102db0 <begin_op>
  if((ip = namei(old)) == 0){
80105024:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105027:	89 04 24             	mov    %eax,(%esp)
8010502a:	e8 91 ce ff ff       	call   80101ec0 <namei>
8010502f:	85 c0                	test   %eax,%eax
80105031:	89 c3                	mov    %eax,%ebx
80105033:	0f 84 a6 00 00 00    	je     801050df <sys_link+0x10f>
    end_op();
    return -1;
  }

  ilock(ip);
80105039:	89 04 24             	mov    %eax,(%esp)
8010503c:	e8 1f cc ff ff       	call   80101c60 <ilock>
  if(ip->type == T_DIR){
80105041:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105046:	0f 84 8b 00 00 00    	je     801050d7 <sys_link+0x107>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010504c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105051:	8d 7d d2             	lea    -0x2e(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80105054:	89 1c 24             	mov    %ebx,(%esp)
80105057:	e8 54 c2 ff ff       	call   801012b0 <iupdate>
  iunlock(ip);
8010505c:	89 1c 24             	mov    %ebx,(%esp)
8010505f:	e8 8c cb ff ff       	call   80101bf0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105064:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105067:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010506b:	89 04 24             	mov    %eax,(%esp)
8010506e:	e8 2d ce ff ff       	call   80101ea0 <nameiparent>
80105073:	85 c0                	test   %eax,%eax
80105075:	89 c6                	mov    %eax,%esi
80105077:	74 49                	je     801050c2 <sys_link+0xf2>
    goto bad;
  ilock(dp);
80105079:	89 04 24             	mov    %eax,(%esp)
8010507c:	e8 df cb ff ff       	call   80101c60 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105081:	8b 06                	mov    (%esi),%eax
80105083:	3b 03                	cmp    (%ebx),%eax
80105085:	75 33                	jne    801050ba <sys_link+0xea>
80105087:	8b 43 04             	mov    0x4(%ebx),%eax
8010508a:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010508e:	89 34 24             	mov    %esi,(%esp)
80105091:	89 44 24 08          	mov    %eax,0x8(%esp)
80105095:	e8 96 c9 ff ff       	call   80101a30 <dirlink>
8010509a:	85 c0                	test   %eax,%eax
8010509c:	78 1c                	js     801050ba <sys_link+0xea>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
8010509e:	89 34 24             	mov    %esi,(%esp)
801050a1:	e8 9a cb ff ff       	call   80101c40 <iunlockput>
  iput(ip);
801050a6:	89 1c 24             	mov    %ebx,(%esp)
801050a9:	e8 82 c3 ff ff       	call   80101430 <iput>

  end_op();
801050ae:	e8 cd db ff ff       	call   80102c80 <end_op>
801050b3:	31 c0                	xor    %eax,%eax

  return 0;
801050b5:	e9 41 ff ff ff       	jmp    80104ffb <sys_link+0x2b>

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
801050ba:	89 34 24             	mov    %esi,(%esp)
801050bd:	e8 7e cb ff ff       	call   80101c40 <iunlockput>
  end_op();

  return 0;

bad:
  ilock(ip);
801050c2:	89 1c 24             	mov    %ebx,(%esp)
801050c5:	e8 96 cb ff ff       	call   80101c60 <ilock>
  ip->nlink--;
801050ca:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050cf:	89 1c 24             	mov    %ebx,(%esp)
801050d2:	e8 d9 c1 ff ff       	call   801012b0 <iupdate>
  iunlockput(ip);
801050d7:	89 1c 24             	mov    %ebx,(%esp)
801050da:	e8 61 cb ff ff       	call   80101c40 <iunlockput>
  end_op();
801050df:	e8 9c db ff ff       	call   80102c80 <end_op>
801050e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
801050e9:	e9 0d ff ff ff       	jmp    80104ffb <sys_link+0x2b>
801050ee:	66 90                	xchg   %ax,%ax

801050f0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801050f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
801050f9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801050fc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801050ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80105103:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010510a:	e8 c1 f8 ff ff       	call   801049d0 <argstr>
8010510f:	85 c0                	test   %eax,%eax
80105111:	79 15                	jns    80105128 <sys_open+0x38>
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105113:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105118:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010511b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010511e:	89 ec                	mov    %ebp,%esp
80105120:	5d                   	pop    %ebp
80105121:	c3                   	ret    
80105122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105128:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010512b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010512f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105136:	e8 05 f8 ff ff       	call   80104940 <argint>
8010513b:	85 c0                	test   %eax,%eax
8010513d:	78 d4                	js     80105113 <sys_open+0x23>
    return -1;

  begin_op();
8010513f:	e8 6c dc ff ff       	call   80102db0 <begin_op>

  if(omode & O_CREATE){
80105144:	f6 45 f1 02          	testb  $0x2,-0xf(%ebp)
80105148:	74 66                	je     801051b0 <sys_open+0xc0>
    ip = create(path, T_FILE, 0, 0);
8010514a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010514d:	31 c9                	xor    %ecx,%ecx
8010514f:	ba 02 00 00 00       	mov    $0x2,%edx
80105154:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010515b:	e8 d0 fb ff ff       	call   80104d30 <create>
    if(ip == 0){
80105160:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105162:	89 c3                	mov    %eax,%ebx
    if(ip == 0){
80105164:	74 3a                	je     801051a0 <sys_open+0xb0>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105166:	e8 75 be ff ff       	call   80100fe0 <filealloc>
8010516b:	85 c0                	test   %eax,%eax
8010516d:	89 c6                	mov    %eax,%esi
8010516f:	74 27                	je     80105198 <sys_open+0xa8>
80105171:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105178:	31 c0                	xor    %eax,%eax
8010517a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80105180:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
80105184:	85 c9                	test   %ecx,%ecx
80105186:	74 58                	je     801051e0 <sys_open+0xf0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105188:	83 c0 01             	add    $0x1,%eax
8010518b:	83 f8 10             	cmp    $0x10,%eax
8010518e:	75 f0                	jne    80105180 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105190:	89 34 24             	mov    %esi,(%esp)
80105193:	e8 c8 be ff ff       	call   80101060 <fileclose>
    iunlockput(ip);
80105198:	89 1c 24             	mov    %ebx,(%esp)
8010519b:	e8 a0 ca ff ff       	call   80101c40 <iunlockput>
    end_op();
801051a0:	e8 db da ff ff       	call   80102c80 <end_op>
801051a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
801051aa:	e9 69 ff ff ff       	jmp    80105118 <sys_open+0x28>
801051af:	90                   	nop
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801051b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051b3:	89 04 24             	mov    %eax,(%esp)
801051b6:	e8 05 cd ff ff       	call   80101ec0 <namei>
801051bb:	85 c0                	test   %eax,%eax
801051bd:	89 c3                	mov    %eax,%ebx
801051bf:	74 df                	je     801051a0 <sys_open+0xb0>
      end_op();
      return -1;
    }
    ilock(ip);
801051c1:	89 04 24             	mov    %eax,(%esp)
801051c4:	e8 97 ca ff ff       	call   80101c60 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801051c9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051ce:	75 96                	jne    80105166 <sys_open+0x76>
801051d0:	8b 75 f0             	mov    -0x10(%ebp),%esi
801051d3:	85 f6                	test   %esi,%esi
801051d5:	74 8f                	je     80105166 <sys_open+0x76>
801051d7:	eb bf                	jmp    80105198 <sys_open+0xa8>
801051d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
801051e0:	89 74 82 28          	mov    %esi,0x28(%edx,%eax,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801051e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801051e7:	89 1c 24             	mov    %ebx,(%esp)
801051ea:	e8 01 ca ff ff       	call   80101bf0 <iunlock>
  end_op();
801051ef:	e8 8c da ff ff       	call   80102c80 <end_op>

  f->type = FD_INODE;
801051f4:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
801051fa:	89 5e 10             	mov    %ebx,0x10(%esi)
  f->off = 0;
801051fd:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80105204:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105207:	83 f2 01             	xor    $0x1,%edx
8010520a:	83 e2 01             	and    $0x1,%edx
8010520d:	88 56 08             	mov    %dl,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105210:	f6 45 f0 03          	testb  $0x3,-0x10(%ebp)
80105214:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
80105218:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010521b:	e9 f8 fe ff ff       	jmp    80105118 <sys_open+0x28>

80105220 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105220:	55                   	push   %ebp
80105221:	89 e5                	mov    %esp,%ebp
80105223:	57                   	push   %edi
80105224:	56                   	push   %esi
80105225:	53                   	push   %ebx
80105226:	83 ec 6c             	sub    $0x6c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105229:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010522c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105230:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105237:	e8 94 f7 ff ff       	call   801049d0 <argstr>
8010523c:	89 c2                	mov    %eax,%edx
8010523e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105243:	85 d2                	test   %edx,%edx
80105245:	0f 88 0b 01 00 00    	js     80105356 <sys_unlink+0x136>
    return -1;

  begin_op();
8010524b:	e8 60 db ff ff       	call   80102db0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105250:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105253:	8d 5d d2             	lea    -0x2e(%ebp),%ebx
80105256:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010525a:	89 04 24             	mov    %eax,(%esp)
8010525d:	e8 3e cc ff ff       	call   80101ea0 <nameiparent>
80105262:	85 c0                	test   %eax,%eax
80105264:	89 45 a4             	mov    %eax,-0x5c(%ebp)
80105267:	0f 84 4e 01 00 00    	je     801053bb <sys_unlink+0x19b>
    end_op();
    return -1;
  }

  ilock(dp);
8010526d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80105270:	89 04 24             	mov    %eax,(%esp)
80105273:	e8 e8 c9 ff ff       	call   80101c60 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105278:	c7 44 24 04 d4 78 10 	movl   $0x801078d4,0x4(%esp)
8010527f:	80 
80105280:	89 1c 24             	mov    %ebx,(%esp)
80105283:	e8 f8 bf ff ff       	call   80101280 <namecmp>
80105288:	85 c0                	test   %eax,%eax
8010528a:	0f 84 20 01 00 00    	je     801053b0 <sys_unlink+0x190>
80105290:	c7 44 24 04 d3 78 10 	movl   $0x801078d3,0x4(%esp)
80105297:	80 
80105298:	89 1c 24             	mov    %ebx,(%esp)
8010529b:	e8 e0 bf ff ff       	call   80101280 <namecmp>
801052a0:	85 c0                	test   %eax,%eax
801052a2:	0f 84 08 01 00 00    	je     801053b0 <sys_unlink+0x190>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801052a8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801052ab:	89 44 24 08          	mov    %eax,0x8(%esp)
801052af:	8b 45 a4             	mov    -0x5c(%ebp),%eax
801052b2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801052b6:	89 04 24             	mov    %eax,(%esp)
801052b9:	e8 c2 c6 ff ff       	call   80101980 <dirlookup>
801052be:	85 c0                	test   %eax,%eax
801052c0:	89 c6                	mov    %eax,%esi
801052c2:	0f 84 e8 00 00 00    	je     801053b0 <sys_unlink+0x190>
    goto bad;
  ilock(ip);
801052c8:	89 04 24             	mov    %eax,(%esp)
801052cb:	e8 90 c9 ff ff       	call   80101c60 <ilock>

  if(ip->nlink < 1)
801052d0:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801052d5:	0f 8e 22 01 00 00    	jle    801053fd <sys_unlink+0x1dd>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801052db:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052e0:	74 7e                	je     80105360 <sys_unlink+0x140>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801052e2:	8d 5d c2             	lea    -0x3e(%ebp),%ebx
801052e5:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801052ec:	00 
801052ed:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801052f4:	00 
801052f5:	89 1c 24             	mov    %ebx,(%esp)
801052f8:	e8 33 f3 ff ff       	call   80104630 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052fd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105300:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105307:	00 
80105308:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010530c:	89 44 24 08          	mov    %eax,0x8(%esp)
80105310:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80105313:	89 04 24             	mov    %eax,(%esp)
80105316:	e8 35 c4 ff ff       	call   80101750 <writei>
8010531b:	83 f8 10             	cmp    $0x10,%eax
8010531e:	0f 85 cd 00 00 00    	jne    801053f1 <sys_unlink+0x1d1>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105324:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105329:	0f 84 a1 00 00 00    	je     801053d0 <sys_unlink+0x1b0>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010532f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80105332:	89 04 24             	mov    %eax,(%esp)
80105335:	e8 06 c9 ff ff       	call   80101c40 <iunlockput>

  ip->nlink--;
8010533a:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
  iupdate(ip);
8010533f:	89 34 24             	mov    %esi,(%esp)
80105342:	e8 69 bf ff ff       	call   801012b0 <iupdate>
  iunlockput(ip);
80105347:	89 34 24             	mov    %esi,(%esp)
8010534a:	e8 f1 c8 ff ff       	call   80101c40 <iunlockput>

  end_op();
8010534f:	e8 2c d9 ff ff       	call   80102c80 <end_op>
80105354:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105356:	83 c4 6c             	add    $0x6c,%esp
80105359:	5b                   	pop    %ebx
8010535a:	5e                   	pop    %esi
8010535b:	5f                   	pop    %edi
8010535c:	5d                   	pop    %ebp
8010535d:	c3                   	ret    
8010535e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105360:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80105364:	0f 86 78 ff ff ff    	jbe    801052e2 <sys_unlink+0xc2>
8010536a:	8d 7d b2             	lea    -0x4e(%ebp),%edi
8010536d:	bb 20 00 00 00       	mov    $0x20,%ebx
80105372:	eb 10                	jmp    80105384 <sys_unlink+0x164>
80105374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105378:	83 c3 10             	add    $0x10,%ebx
8010537b:	3b 5e 58             	cmp    0x58(%esi),%ebx
8010537e:	0f 83 5e ff ff ff    	jae    801052e2 <sys_unlink+0xc2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105384:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
8010538b:	00 
8010538c:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80105390:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105394:	89 34 24             	mov    %esi,(%esp)
80105397:	e8 d4 c4 ff ff       	call   80101870 <readi>
8010539c:	83 f8 10             	cmp    $0x10,%eax
8010539f:	75 44                	jne    801053e5 <sys_unlink+0x1c5>
      panic("isdirempty: readi");
    if(de.inum != 0)
801053a1:	66 83 7d b2 00       	cmpw   $0x0,-0x4e(%ebp)
801053a6:	74 d0                	je     80105378 <sys_unlink+0x158>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801053a8:	89 34 24             	mov    %esi,(%esp)
801053ab:	e8 90 c8 ff ff       	call   80101c40 <iunlockput>
  end_op();

  return 0;

bad:
  iunlockput(dp);
801053b0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
801053b3:	89 04 24             	mov    %eax,(%esp)
801053b6:	e8 85 c8 ff ff       	call   80101c40 <iunlockput>
  end_op();
801053bb:	e8 c0 d8 ff ff       	call   80102c80 <end_op>
  return -1;
}
801053c0:	83 c4 6c             	add    $0x6c,%esp

  return 0;

bad:
  iunlockput(dp);
  end_op();
801053c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
801053c8:	5b                   	pop    %ebx
801053c9:	5e                   	pop    %esi
801053ca:	5f                   	pop    %edi
801053cb:	5d                   	pop    %ebp
801053cc:	c3                   	ret    
801053cd:	8d 76 00             	lea    0x0(%esi),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801053d0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
801053d3:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801053d8:	89 04 24             	mov    %eax,(%esp)
801053db:	e8 d0 be ff ff       	call   801012b0 <iupdate>
801053e0:	e9 4a ff ff ff       	jmp    8010532f <sys_unlink+0x10f>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801053e5:	c7 04 24 04 79 10 80 	movl   $0x80107904,(%esp)
801053ec:	e8 df af ff ff       	call   801003d0 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
801053f1:	c7 04 24 16 79 10 80 	movl   $0x80107916,(%esp)
801053f8:	e8 d3 af ff ff       	call   801003d0 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
801053fd:	c7 04 24 f2 78 10 80 	movl   $0x801078f2,(%esp)
80105404:	e8 c7 af ff ff       	call   801003d0 <panic>
80105409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105410 <argfd.clone.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	83 ec 28             	sub    $0x28,%esp
80105416:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105419:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010541b:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
8010541e:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105421:	89 d6                	mov    %edx,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105423:	89 44 24 04          	mov    %eax,0x4(%esp)
80105427:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010542e:	e8 0d f5 ff ff       	call   80104940 <argint>
80105433:	85 c0                	test   %eax,%eax
80105435:	79 11                	jns    80105448 <argfd.clone.0+0x38>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
80105437:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return 0;
}
8010543c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010543f:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105442:	89 ec                	mov    %ebp,%esp
80105444:	5d                   	pop    %ebp
80105445:	c3                   	ret    
80105446:	66 90                	xchg   %ax,%ax
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105448:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010544b:	83 f8 0f             	cmp    $0xf,%eax
8010544e:	77 e7                	ja     80105437 <argfd.clone.0+0x27>
80105450:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105457:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
8010545b:	85 d2                	test   %edx,%edx
8010545d:	74 d8                	je     80105437 <argfd.clone.0+0x27>
    return -1;
  if(pfd)
8010545f:	85 db                	test   %ebx,%ebx
80105461:	74 02                	je     80105465 <argfd.clone.0+0x55>
    *pfd = fd;
80105463:	89 03                	mov    %eax,(%ebx)
  if(pf)
80105465:	31 c0                	xor    %eax,%eax
80105467:	85 f6                	test   %esi,%esi
80105469:	74 d1                	je     8010543c <argfd.clone.0+0x2c>
    *pf = f;
8010546b:	89 16                	mov    %edx,(%esi)
8010546d:	eb cd                	jmp    8010543c <argfd.clone.0+0x2c>
8010546f:	90                   	nop

80105470 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80105470:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105471:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80105473:	89 e5                	mov    %esp,%ebp
80105475:	53                   	push   %ebx
80105476:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105479:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010547c:	e8 8f ff ff ff       	call   80105410 <argfd.clone.0>
80105481:	85 c0                	test   %eax,%eax
80105483:	79 13                	jns    80105498 <sys_dup+0x28>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105485:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
8010548a:	89 d8                	mov    %ebx,%eax
8010548c:	83 c4 24             	add    $0x24,%esp
8010548f:	5b                   	pop    %ebx
80105490:	5d                   	pop    %ebp
80105491:	c3                   	ret    
80105492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80105498:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010549b:	31 db                	xor    %ebx,%ebx
8010549d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054a3:	eb 0b                	jmp    801054b0 <sys_dup+0x40>
801054a5:	8d 76 00             	lea    0x0(%esi),%esi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801054a8:	83 c3 01             	add    $0x1,%ebx
801054ab:	83 fb 10             	cmp    $0x10,%ebx
801054ae:	74 d5                	je     80105485 <sys_dup+0x15>
    if(proc->ofile[fd] == 0){
801054b0:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
801054b4:	85 c9                	test   %ecx,%ecx
801054b6:	75 f0                	jne    801054a8 <sys_dup+0x38>
      proc->ofile[fd] = f;
801054b8:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
801054bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054bf:	89 04 24             	mov    %eax,(%esp)
801054c2:	e8 c9 ba ff ff       	call   80100f90 <filedup>
  return fd;
801054c7:	eb c1                	jmp    8010548a <sys_dup+0x1a>
801054c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054d0 <sys_read>:
}

int
sys_read(void)
{
801054d0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054d1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
801054d3:	89 e5                	mov    %esp,%ebp
801054d5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054d8:	8d 55 f4             	lea    -0xc(%ebp),%edx
801054db:	e8 30 ff ff ff       	call   80105410 <argfd.clone.0>
801054e0:	85 c0                	test   %eax,%eax
801054e2:	79 0c                	jns    801054f0 <sys_read+0x20>
    return -1;
  return fileread(f, p, n);
801054e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054e9:	c9                   	leave  
801054ea:	c3                   	ret    
801054eb:	90                   	nop
801054ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054f0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054f3:	89 44 24 04          	mov    %eax,0x4(%esp)
801054f7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801054fe:	e8 3d f4 ff ff       	call   80104940 <argint>
80105503:	85 c0                	test   %eax,%eax
80105505:	78 dd                	js     801054e4 <sys_read+0x14>
80105507:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010550a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105511:	89 44 24 08          	mov    %eax,0x8(%esp)
80105515:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105518:	89 44 24 04          	mov    %eax,0x4(%esp)
8010551c:	e8 5f f4 ff ff       	call   80104980 <argptr>
80105521:	85 c0                	test   %eax,%eax
80105523:	78 bf                	js     801054e4 <sys_read+0x14>
    return -1;
  return fileread(f, p, n);
80105525:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105528:	89 44 24 08          	mov    %eax,0x8(%esp)
8010552c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010552f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105533:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105536:	89 04 24             	mov    %eax,(%esp)
80105539:	e8 42 b9 ff ff       	call   80100e80 <fileread>
}
8010553e:	c9                   	leave  
8010553f:	c3                   	ret    

80105540 <sys_write>:

int
sys_write(void)
{
80105540:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105541:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80105543:	89 e5                	mov    %esp,%ebp
80105545:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105548:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010554b:	e8 c0 fe ff ff       	call   80105410 <argfd.clone.0>
80105550:	85 c0                	test   %eax,%eax
80105552:	79 0c                	jns    80105560 <sys_write+0x20>
    return -1;
  return filewrite(f, p, n);
80105554:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105559:	c9                   	leave  
8010555a:	c3                   	ret    
8010555b:	90                   	nop
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105560:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105563:	89 44 24 04          	mov    %eax,0x4(%esp)
80105567:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010556e:	e8 cd f3 ff ff       	call   80104940 <argint>
80105573:	85 c0                	test   %eax,%eax
80105575:	78 dd                	js     80105554 <sys_write+0x14>
80105577:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010557a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105581:	89 44 24 08          	mov    %eax,0x8(%esp)
80105585:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105588:	89 44 24 04          	mov    %eax,0x4(%esp)
8010558c:	e8 ef f3 ff ff       	call   80104980 <argptr>
80105591:	85 c0                	test   %eax,%eax
80105593:	78 bf                	js     80105554 <sys_write+0x14>
    return -1;
  return filewrite(f, p, n);
80105595:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105598:	89 44 24 08          	mov    %eax,0x8(%esp)
8010559c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010559f:	89 44 24 04          	mov    %eax,0x4(%esp)
801055a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055a6:	89 04 24             	mov    %eax,(%esp)
801055a9:	e8 b2 b7 ff ff       	call   80100d60 <filewrite>
}
801055ae:	c9                   	leave  
801055af:	c3                   	ret    

801055b0 <sys_fstat>:
  return 0;
}

int
sys_fstat(void)
{
801055b0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801055b1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
801055b3:	89 e5                	mov    %esp,%ebp
801055b5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801055b8:	8d 55 f4             	lea    -0xc(%ebp),%edx
801055bb:	e8 50 fe ff ff       	call   80105410 <argfd.clone.0>
801055c0:	85 c0                	test   %eax,%eax
801055c2:	79 0c                	jns    801055d0 <sys_fstat+0x20>
    return -1;
  return filestat(f, st);
801055c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055c9:	c9                   	leave  
801055ca:	c3                   	ret    
801055cb:	90                   	nop
801055cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_fstat(void)
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801055d0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055d3:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
801055da:	00 
801055db:	89 44 24 04          	mov    %eax,0x4(%esp)
801055df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801055e6:	e8 95 f3 ff ff       	call   80104980 <argptr>
801055eb:	85 c0                	test   %eax,%eax
801055ed:	78 d5                	js     801055c4 <sys_fstat+0x14>
    return -1;
  return filestat(f, st);
801055ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801055f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055f9:	89 04 24             	mov    %eax,(%esp)
801055fc:	e8 3f b9 ff ff       	call   80100f40 <filestat>
}
80105601:	c9                   	leave  
80105602:	c3                   	ret    
80105603:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105610 <sys_close>:
  return filewrite(f, p, n);
}

int
sys_close(void)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105616:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105619:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010561c:	e8 ef fd ff ff       	call   80105410 <argfd.clone.0>
80105621:	89 c2                	mov    %eax,%edx
80105623:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105628:	85 d2                	test   %edx,%edx
8010562a:	78 1e                	js     8010564a <sys_close+0x3a>
    return -1;
  proc->ofile[fd] = 0;
8010562c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105632:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105635:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
8010563c:	00 
  fileclose(f);
8010563d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105640:	89 04 24             	mov    %eax,(%esp)
80105643:	e8 18 ba ff ff       	call   80101060 <fileclose>
80105648:	31 c0                	xor    %eax,%eax
  return 0;
}
8010564a:	c9                   	leave  
8010564b:	c3                   	ret    
8010564c:	00 00                	add    %al,(%eax)
	...

80105650 <sys_getpid>:
  return kill(pid);
}

int
sys_getpid(void)
{
80105650:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105656:	55                   	push   %ebp
80105657:	89 e5                	mov    %esp,%ebp
  return proc->pid;
}
80105659:	5d                   	pop    %ebp
  return kill(pid);
}

int
sys_getpid(void)
{
8010565a:	8b 40 10             	mov    0x10(%eax),%eax
  return proc->pid;
}
8010565d:	c3                   	ret    
8010565e:	66 90                	xchg   %ax,%ax

80105660 <sys_hello>:
  release(&tickslock);
  return xticks;
}
int
sys_hello(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	83 ec 08             	sub    $0x8,%esp
  hello();
80105666:	e8 b5 e0 ff ff       	call   80103720 <hello>
  return 0;
}
8010566b:	31 c0                	xor    %eax,%eax
8010566d:	c9                   	leave  
8010566e:	c3                   	ret    
8010566f:	90                   	nop

80105670 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	53                   	push   %ebx
80105674:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80105677:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
8010567e:	e8 0d ef ff ff       	call   80104590 <acquire>
  xticks = ticks;
80105683:	8b 1d 20 57 11 80    	mov    0x80115720,%ebx
  release(&tickslock);
80105689:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
80105690:	e8 ab ee ff ff       	call   80104540 <release>
  return xticks;
}
80105695:	83 c4 14             	add    $0x14,%esp
80105698:	89 d8                	mov    %ebx,%eax
8010569a:	5b                   	pop    %ebx
8010569b:	5d                   	pop    %ebp
8010569c:	c3                   	ret    
8010569d:	8d 76 00             	lea    0x0(%esi),%esi

801056a0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	53                   	push   %ebx
801056a4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801056a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056aa:	89 44 24 04          	mov    %eax,0x4(%esp)
801056ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801056b5:	e8 86 f2 ff ff       	call   80104940 <argint>
801056ba:	89 c2                	mov    %eax,%edx
801056bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056c1:	85 d2                	test   %edx,%edx
801056c3:	78 59                	js     8010571e <sys_sleep+0x7e>
    return -1;
  acquire(&tickslock);
801056c5:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
801056cc:	e8 bf ee ff ff       	call   80104590 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801056d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801056d4:	8b 1d 20 57 11 80    	mov    0x80115720,%ebx
  while(ticks - ticks0 < n){
801056da:	85 d2                	test   %edx,%edx
801056dc:	75 22                	jne    80105700 <sys_sleep+0x60>
801056de:	eb 48                	jmp    80105728 <sys_sleep+0x88>
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801056e0:	c7 44 24 04 e0 4e 11 	movl   $0x80114ee0,0x4(%esp)
801056e7:	80 
801056e8:	c7 04 24 20 57 11 80 	movl   $0x80115720,(%esp)
801056ef:	e8 0c e3 ff ff       	call   80103a00 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801056f4:	a1 20 57 11 80       	mov    0x80115720,%eax
801056f9:	29 d8                	sub    %ebx,%eax
801056fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801056fe:	73 28                	jae    80105728 <sys_sleep+0x88>
    if(proc->killed){
80105700:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105706:	8b 40 24             	mov    0x24(%eax),%eax
80105709:	85 c0                	test   %eax,%eax
8010570b:	74 d3                	je     801056e0 <sys_sleep+0x40>
      release(&tickslock);
8010570d:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
80105714:	e8 27 ee ff ff       	call   80104540 <release>
80105719:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
8010571e:	83 c4 24             	add    $0x24,%esp
80105721:	5b                   	pop    %ebx
80105722:	5d                   	pop    %ebp
80105723:	c3                   	ret    
80105724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105728:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
8010572f:	e8 0c ee ff ff       	call   80104540 <release>
  return 0;
}
80105734:	83 c4 24             	add    $0x24,%esp
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105737:	31 c0                	xor    %eax,%eax
  return 0;
}
80105739:	5b                   	pop    %ebx
8010573a:	5d                   	pop    %ebp
8010573b:	c3                   	ret    
8010573c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105740 <sys_sbrk>:
  return proc->pid;
}

int
sys_sbrk(void)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	53                   	push   %ebx
80105744:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105747:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010574a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010574e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105755:	e8 e6 f1 ff ff       	call   80104940 <argint>
8010575a:	85 c0                	test   %eax,%eax
8010575c:	79 12                	jns    80105770 <sys_sbrk+0x30>
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
8010575e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105763:	83 c4 24             	add    $0x24,%esp
80105766:	5b                   	pop    %ebx
80105767:	5d                   	pop    %ebp
80105768:	c3                   	ret    
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
80105770:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105776:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105778:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010577b:	89 04 24             	mov    %eax,(%esp)
8010577e:	e8 cd e9 ff ff       	call   80104150 <growproc>
80105783:	89 c2                	mov    %eax,%edx
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
80105785:	89 d8                	mov    %ebx,%eax
  if(growproc(n) < 0)
80105787:	85 d2                	test   %edx,%edx
80105789:	79 d8                	jns    80105763 <sys_sbrk+0x23>
8010578b:	eb d1                	jmp    8010575e <sys_sbrk+0x1e>
8010578d:	8d 76 00             	lea    0x0(%esi),%esi

80105790 <sys_kill>:
	return 0;
}

int
sys_kill(void)
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105796:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105799:	89 44 24 04          	mov    %eax,0x4(%esp)
8010579d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801057a4:	e8 97 f1 ff ff       	call   80104940 <argint>
801057a9:	89 c2                	mov    %eax,%edx
801057ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057b0:	85 d2                	test   %edx,%edx
801057b2:	78 0b                	js     801057bf <sys_kill+0x2f>
    return -1;
  return kill(pid);
801057b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057b7:	89 04 24             	mov    %eax,(%esp)
801057ba:	e8 51 e0 ff ff       	call   80103810 <kill>
}
801057bf:	c9                   	leave  
801057c0:	c3                   	ret    
801057c1:	eb 0d                	jmp    801057d0 <sys_setpriority>
801057c3:	90                   	nop
801057c4:	90                   	nop
801057c5:	90                   	nop
801057c6:	90                   	nop
801057c7:	90                   	nop
801057c8:	90                   	nop
801057c9:	90                   	nop
801057ca:	90                   	nop
801057cb:	90                   	nop
801057cc:	90                   	nop
801057cd:	90                   	nop
801057ce:	90                   	nop
801057cf:	90                   	nop

801057d0 <sys_setpriority>:

	return(waitpid(pid,waitStatus,arg));
}

int 
sys_setpriority(void) { //added the setpriority system call so that it takes 2 arguments. (lab1 part2)
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	83 ec 28             	sub    $0x28,%esp
	//int pid;
	int priority;
	if(argint(0, &priority) < 0){
801057d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801057dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801057e4:	e8 57 f1 ff ff       	call   80104940 <argint>
801057e9:	89 c2                	mov    %eax,%edx
801057eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057f0:	85 d2                	test   %edx,%edx
801057f2:	78 0d                	js     80105801 <sys_setpriority+0x31>
		return -1;
	}
	setpriority(priority);
801057f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057f7:	89 04 24             	mov    %eax,(%esp)
801057fa:	e8 01 df ff ff       	call   80103700 <setpriority>
801057ff:	31 c0                	xor    %eax,%eax
	return 0;
}
80105801:	c9                   	leave  
80105802:	c3                   	ret    
80105803:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105810 <sys_waitpid>:
  return wait(waitStatus);
}

int
sys_waitpid(void) //  Added waitpid sstem call which waits for a process with a pid that is equal to the pid provided by the argumet handles errors
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	83 ec 28             	sub    $0x28,%esp
	int pid;
	int *waitStatus;
	int arg;
	
	if(argint(0, &pid) < 0) {
80105816:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105819:	89 44 24 04          	mov    %eax,0x4(%esp)
8010581d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105824:	e8 17 f1 ff ff       	call   80104940 <argint>
80105829:	85 c0                	test   %eax,%eax
8010582b:	79 0b                	jns    80105838 <sys_waitpid+0x28>
	}
	if(argint(2, &arg) > 100) {
		return -1;
	}

	return(waitpid(pid,waitStatus,arg));
8010582d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105832:	c9                   	leave  
80105833:	c3                   	ret    
80105834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	int arg;
	
	if(argint(0, &pid) < 0) {
		return -1;
	}
	if(argptr(1, (char**)&waitStatus, sizeof(int)) > 0){
80105838:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010583b:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80105842:	00 
80105843:	89 44 24 04          	mov    %eax,0x4(%esp)
80105847:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010584e:	e8 2d f1 ff ff       	call   80104980 <argptr>
80105853:	85 c0                	test   %eax,%eax
80105855:	7f d6                	jg     8010582d <sys_waitpid+0x1d>
		return -1;
	}
	if(argint(2, &arg) > 100) {
80105857:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010585a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010585e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105865:	e8 d6 f0 ff ff       	call   80104940 <argint>
8010586a:	83 f8 64             	cmp    $0x64,%eax
8010586d:	7f be                	jg     8010582d <sys_waitpid+0x1d>
		return -1;
	}

	return(waitpid(pid,waitStatus,arg));
8010586f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105872:	89 44 24 08          	mov    %eax,0x8(%esp)
80105876:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105879:	89 44 24 04          	mov    %eax,0x4(%esp)
8010587d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105880:	89 04 24             	mov    %eax,(%esp)
80105883:	e8 68 e3 ff ff       	call   80103bf0 <waitpid>
}
80105888:	c9                   	leave  
80105889:	c3                   	ret    
8010588a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105890 <sys_wait>:
  return 0;  // not reached
}

int
sys_wait(void) // update sys_wait to wiat for a process with a pod that equals the one provided by the waitStatus argument (lab1 part1b)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	83 ec 28             	sub    $0x28,%esp
  int *waitStatus;

  if (argptr(0, (char**)&waitStatus, sizeof(int)) > 0) {
80105896:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105899:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801058a0:	00 
801058a1:	89 44 24 04          	mov    %eax,0x4(%esp)
801058a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801058ac:	e8 cf f0 ff ff       	call   80104980 <argptr>
801058b1:	89 c2                	mov    %eax,%edx
801058b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058b8:	85 d2                	test   %edx,%edx
801058ba:	7e 04                	jle    801058c0 <sys_wait+0x30>
	  return -1;
  }
  return wait(waitStatus);
}
801058bc:	c9                   	leave  
801058bd:	c3                   	ret    
801058be:	66 90                	xchg   %ax,%ax
  int *waitStatus;

  if (argptr(0, (char**)&waitStatus, sizeof(int)) > 0) {
	  return -1;
  }
  return wait(waitStatus);
801058c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058c3:	89 04 24             	mov    %eax,(%esp)
801058c6:	e8 25 e4 ff ff       	call   80103cf0 <wait>
}
801058cb:	c9                   	leave  
801058cc:	c3                   	ret    
801058cd:	8d 76 00             	lea    0x0(%esi),%esi

801058d0 <sys_exit>:
  return fork();
}

int
sys_exit(void) // modified exit to handle a exit status (lab1 part1: a)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	83 ec 28             	sub    $0x28,%esp
  int status;
  
  if (argint(0, &status) > 0) {
801058d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801058dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801058e4:	e8 57 f0 ff ff       	call   80104940 <argint>
801058e9:	89 c2                	mov    %eax,%edx
801058eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058f0:	85 d2                	test   %edx,%edx
801058f2:	7e 04                	jle    801058f8 <sys_exit+0x28>
  }
  else{
	 exit(status);   
  }
  return 0;  // not reached
}
801058f4:	c9                   	leave  
801058f5:	c3                   	ret    
801058f6:	66 90                	xchg   %ax,%ax
  
  if (argint(0, &status) > 0) {
	  return -1;  
  }
  else{
	 exit(status);   
801058f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058fb:	89 04 24             	mov    %eax,(%esp)
801058fe:	e8 ed e4 ff ff       	call   80103df0 <exit>
80105903:	31 c0                	xor    %eax,%eax
  }
  return 0;  // not reached
}
80105905:	c9                   	leave  
80105906:	c3                   	ret    
80105907:	89 f6                	mov    %esi,%esi
80105909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105910 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	83 ec 08             	sub    $0x8,%esp
  return fork();
}
80105916:	c9                   	leave  
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105917:	e9 14 e7 ff ff       	jmp    80104030 <fork>
8010591c:	00 00                	add    %al,(%eax)
	...

80105920 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105920:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105921:	ba 43 00 00 00       	mov    $0x43,%edx
80105926:	89 e5                	mov    %esp,%ebp
80105928:	83 ec 18             	sub    $0x18,%esp
8010592b:	b8 34 00 00 00       	mov    $0x34,%eax
80105930:	ee                   	out    %al,(%dx)
80105931:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
80105936:	b2 40                	mov    $0x40,%dl
80105938:	ee                   	out    %al,(%dx)
80105939:	b8 2e 00 00 00       	mov    $0x2e,%eax
8010593e:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
8010593f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105946:	e8 75 d9 ff ff       	call   801032c0 <picenable>
}
8010594b:	c9                   	leave  
8010594c:	c3                   	ret    
8010594d:	00 00                	add    %al,(%eax)
	...

80105950 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105950:	1e                   	push   %ds
  pushl %es
80105951:	06                   	push   %es
  pushl %fs
80105952:	0f a0                	push   %fs
  pushl %gs
80105954:	0f a8                	push   %gs
  pushal
80105956:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80105957:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010595b:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010595d:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
8010595f:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80105963:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80105965:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80105967:	54                   	push   %esp
  call trap
80105968:	e8 43 00 00 00       	call   801059b0 <trap>
  addl $4, %esp
8010596d:	83 c4 04             	add    $0x4,%esp

80105970 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105970:	61                   	popa   
  popl %gs
80105971:	0f a9                	pop    %gs
  popl %fs
80105973:	0f a1                	pop    %fs
  popl %es
80105975:	07                   	pop    %es
  popl %ds
80105976:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105977:	83 c4 08             	add    $0x8,%esp
  iret
8010597a:	cf                   	iret   
8010597b:	00 00                	add    %al,(%eax)
8010597d:	00 00                	add    %al,(%eax)
	...

80105980 <idtinit>:
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
80105980:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
80105981:	b8 20 4f 11 80       	mov    $0x80114f20,%eax
80105986:	89 e5                	mov    %esp,%ebp
80105988:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
8010598b:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80105991:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105995:	c1 e8 10             	shr    $0x10,%eax
80105998:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
8010599c:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010599f:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801059a2:	c9                   	leave  
801059a3:	c3                   	ret    
801059a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801059b0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
801059b3:	83 ec 38             	sub    $0x38,%esp
801059b6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801059b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059bc:	89 75 f8             	mov    %esi,-0x8(%ebp)
801059bf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
801059c2:	8b 43 30             	mov    0x30(%ebx),%eax
801059c5:	83 f8 40             	cmp    $0x40,%eax
801059c8:	0f 84 d2 00 00 00    	je     80105aa0 <trap+0xf0>
    if(proc->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
801059ce:	83 e8 20             	sub    $0x20,%eax
801059d1:	83 f8 1f             	cmp    $0x1f,%eax
801059d4:	0f 86 be 00 00 00    	jbe    80105a98 <trap+0xe8>
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
801059da:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
801059e1:	85 c9                	test   %ecx,%ecx
801059e3:	0f 84 fe 01 00 00    	je     80105be7 <trap+0x237>
801059e9:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801059ed:	0f 84 f4 01 00 00    	je     80105be7 <trap+0x237>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801059f3:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801059f6:	8b 73 38             	mov    0x38(%ebx),%esi
801059f9:	e8 22 d0 ff ff       	call   80102a20 <cpunum>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
801059fe:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a05:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
80105a09:	89 74 24 18          	mov    %esi,0x18(%esp)
80105a0d:	89 44 24 14          	mov    %eax,0x14(%esp)
80105a11:	8b 43 34             	mov    0x34(%ebx),%eax
80105a14:	89 44 24 10          	mov    %eax,0x10(%esp)
80105a18:	8b 43 30             	mov    0x30(%ebx),%eax
80105a1b:	89 44 24 0c          	mov    %eax,0xc(%esp)
80105a1f:	8d 42 6c             	lea    0x6c(%edx),%eax
80105a22:	89 44 24 08          	mov    %eax,0x8(%esp)
80105a26:	8b 42 10             	mov    0x10(%edx),%eax
80105a29:	c7 04 24 80 79 10 80 	movl   $0x80107980,(%esp)
80105a30:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a34:	e8 37 ae ff ff       	call   80100870 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
80105a39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a3f:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105a46:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105a48:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a4e:	85 c0                	test   %eax,%eax
80105a50:	74 34                	je     80105a86 <trap+0xd6>
80105a52:	8b 50 24             	mov    0x24(%eax),%edx
80105a55:	85 d2                	test   %edx,%edx
80105a57:	74 10                	je     80105a69 <trap+0xb9>
80105a59:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105a5d:	83 e2 03             	and    $0x3,%edx
80105a60:	83 fa 03             	cmp    $0x3,%edx
80105a63:	0f 84 5f 01 00 00    	je     80105bc8 <trap+0x218>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105a69:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a6d:	0f 84 2d 01 00 00    	je     80105ba0 <trap+0x1f0>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105a73:	8b 40 24             	mov    0x24(%eax),%eax
80105a76:	85 c0                	test   %eax,%eax
80105a78:	74 0c                	je     80105a86 <trap+0xd6>
80105a7a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a7e:	83 e0 03             	and    $0x3,%eax
80105a81:	83 f8 03             	cmp    $0x3,%eax
80105a84:	74 3c                	je     80105ac2 <trap+0x112>
    exit(0);
}
80105a86:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105a89:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105a8c:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105a8f:	89 ec                	mov    %ebp,%esp
80105a91:	5d                   	pop    %ebp
80105a92:	c3                   	ret    
80105a93:	90                   	nop
80105a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80105a98:	ff 24 85 d0 79 10 80 	jmp    *-0x7fef8630(,%eax,4)
80105a9f:	90                   	nop
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
80105aa0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105aa6:	8b 70 24             	mov    0x24(%eax),%esi
80105aa9:	85 f6                	test   %esi,%esi
80105aab:	75 33                	jne    80105ae0 <trap+0x130>
      exit(0);
    proc->tf = tf;
80105aad:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105ab0:	e8 9b ef ff ff       	call   80104a50 <syscall>
    if(proc->killed)
80105ab5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105abb:	8b 58 24             	mov    0x24(%eax),%ebx
80105abe:	85 db                	test   %ebx,%ebx
80105ac0:	74 c4                	je     80105a86 <trap+0xd6>
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit(0);
80105ac2:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80105ac9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105acc:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105acf:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105ad2:	89 ec                	mov    %ebp,%esp
80105ad4:	5d                   	pop    %ebp
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit(0);
80105ad5:	e9 16 e3 ff ff       	jmp    80103df0 <exit>
80105ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit(0);
80105ae0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105ae7:	e8 04 e3 ff ff       	call   80103df0 <exit>
80105aec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105af2:	eb b9                	jmp    80105aad <trap+0xfd>
80105af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105af8:	e8 23 c6 ff ff       	call   80102120 <ideintr>
    lapiceoi();
80105afd:	e8 4e cc ff ff       	call   80102750 <lapiceoi>
    break;
80105b02:	e9 41 ff ff ff       	jmp    80105a48 <trap+0x98>
80105b07:	90                   	nop
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b08:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b0b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105b0f:	e8 0c cf ff ff       	call   80102a20 <cpunum>
80105b14:	c7 04 24 28 79 10 80 	movl   $0x80107928,(%esp)
80105b1b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105b1f:	89 74 24 08          	mov    %esi,0x8(%esp)
80105b23:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b27:	e8 44 ad ff ff       	call   80100870 <cprintf>
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
80105b2c:	e8 1f cc ff ff       	call   80102750 <lapiceoi>
    break;
80105b31:	e9 12 ff ff ff       	jmp    80105a48 <trap+0x98>
80105b36:	66 90                	xchg   %ax,%ax
80105b38:	90                   	nop
80105b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105b40:	e8 9b 01 00 00       	call   80105ce0 <uartintr>
    lapiceoi();
80105b45:	e8 06 cc ff ff       	call   80102750 <lapiceoi>
    break;
80105b4a:	e9 f9 fe ff ff       	jmp    80105a48 <trap+0x98>
80105b4f:	90                   	nop
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105b50:	e8 9b ca ff ff       	call   801025f0 <kbdintr>
    lapiceoi();
80105b55:	e8 f6 cb ff ff       	call   80102750 <lapiceoi>
    break;
80105b5a:	e9 e9 fe ff ff       	jmp    80105a48 <trap+0x98>
80105b5f:	90                   	nop
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105b60:	e8 bb ce ff ff       	call   80102a20 <cpunum>
80105b65:	85 c0                	test   %eax,%eax
80105b67:	75 94                	jne    80105afd <trap+0x14d>
      acquire(&tickslock);
80105b69:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
80105b70:	e8 1b ea ff ff       	call   80104590 <acquire>
      ticks++;
80105b75:	83 05 20 57 11 80 01 	addl   $0x1,0x80115720
      wakeup(&ticks);
80105b7c:	c7 04 24 20 57 11 80 	movl   $0x80115720,(%esp)
80105b83:	e8 18 dd ff ff       	call   801038a0 <wakeup>
      release(&tickslock);
80105b88:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
80105b8f:	e8 ac e9 ff ff       	call   80104540 <release>
80105b94:	e9 64 ff ff ff       	jmp    80105afd <trap+0x14d>
80105b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105ba0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105ba4:	0f 85 c9 fe ff ff    	jne    80105a73 <trap+0xc3>
80105baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    yield();
80105bb0:	e8 1b df ff ff       	call   80103ad0 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105bb5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bbb:	85 c0                	test   %eax,%eax
80105bbd:	0f 85 b0 fe ff ff    	jne    80105a73 <trap+0xc3>
80105bc3:	e9 be fe ff ff       	jmp    80105a86 <trap+0xd6>

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit(0);
80105bc8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105bcf:	e8 1c e2 ff ff       	call   80103df0 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105bd4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bda:	85 c0                	test   %eax,%eax
80105bdc:	0f 85 87 fe ff ff    	jne    80105a69 <trap+0xb9>
80105be2:	e9 9f fe ff ff       	jmp    80105a86 <trap+0xd6>
80105be7:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105bea:	8b 73 38             	mov    0x38(%ebx),%esi
80105bed:	e8 2e ce ff ff       	call   80102a20 <cpunum>
80105bf2:	89 7c 24 10          	mov    %edi,0x10(%esp)
80105bf6:	89 74 24 0c          	mov    %esi,0xc(%esp)
80105bfa:	89 44 24 08          	mov    %eax,0x8(%esp)
80105bfe:	8b 43 30             	mov    0x30(%ebx),%eax
80105c01:	c7 04 24 4c 79 10 80 	movl   $0x8010794c,(%esp)
80105c08:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c0c:	e8 5f ac ff ff       	call   80100870 <cprintf>
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
80105c11:	c7 04 24 c3 79 10 80 	movl   $0x801079c3,(%esp)
80105c18:	e8 b3 a7 ff ff       	call   801003d0 <panic>
80105c1d:	8d 76 00             	lea    0x0(%esi),%esi

80105c20 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105c20:	55                   	push   %ebp
80105c21:	31 c0                	xor    %eax,%eax
80105c23:	89 e5                	mov    %esp,%ebp
80105c25:	ba 20 4f 11 80       	mov    $0x80114f20,%edx
80105c2a:	83 ec 18             	sub    $0x18,%esp
80105c2d:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105c30:	8b 0c 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%ecx
80105c37:	66 89 0c c5 20 4f 11 	mov    %cx,-0x7feeb0e0(,%eax,8)
80105c3e:	80 
80105c3f:	c1 e9 10             	shr    $0x10,%ecx
80105c42:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
80105c49:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
80105c4e:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
80105c53:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105c58:	83 c0 01             	add    $0x1,%eax
80105c5b:	3d 00 01 00 00       	cmp    $0x100,%eax
80105c60:	75 ce                	jne    80105c30 <tvinit+0x10>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c62:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105c67:	c7 44 24 04 c8 79 10 	movl   $0x801079c8,0x4(%esp)
80105c6e:	80 
80105c6f:	c7 04 24 e0 4e 11 80 	movl   $0x80114ee0,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c76:	66 c7 05 22 51 11 80 	movw   $0x8,0x80115122
80105c7d:	08 00 
80105c7f:	66 a3 20 51 11 80    	mov    %ax,0x80115120
80105c85:	c1 e8 10             	shr    $0x10,%eax
80105c88:	c6 05 24 51 11 80 00 	movb   $0x0,0x80115124
80105c8f:	c6 05 25 51 11 80 ef 	movb   $0xef,0x80115125
80105c96:	66 a3 26 51 11 80    	mov    %ax,0x80115126

  initlock(&tickslock, "time");
80105c9c:	e8 5f e7 ff ff       	call   80104400 <initlock>
}
80105ca1:	c9                   	leave  
80105ca2:	c3                   	ret    
	...

80105cb0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105cb0:	a1 c8 a5 10 80       	mov    0x8010a5c8,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105cb5:	55                   	push   %ebp
80105cb6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105cb8:	85 c0                	test   %eax,%eax
80105cba:	75 0c                	jne    80105cc8 <uartgetc+0x18>
    return -1;
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
80105cbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cc1:	5d                   	pop    %ebp
80105cc2:	c3                   	ret    
80105cc3:	90                   	nop
80105cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cc8:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ccd:	ec                   	in     (%dx),%al
static int
uartgetc(void)
{
  if(!uart)
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105cce:	a8 01                	test   $0x1,%al
80105cd0:	74 ea                	je     80105cbc <uartgetc+0xc>
80105cd2:	b2 f8                	mov    $0xf8,%dl
80105cd4:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105cd5:	0f b6 c0             	movzbl %al,%eax
}
80105cd8:	5d                   	pop    %ebp
80105cd9:	c3                   	ret    
80105cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105ce0 <uartintr>:

void
uartintr(void)
{
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
80105ce3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105ce6:	c7 04 24 b0 5c 10 80 	movl   $0x80105cb0,(%esp)
80105ced:	e8 4e a9 ff ff       	call   80100640 <consoleintr>
}
80105cf2:	c9                   	leave  
80105cf3:	c3                   	ret    
80105cf4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105d00 <uartputc>:
    uartputc(*p);
}

void
uartputc(int c)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	56                   	push   %esi
80105d04:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d09:	53                   	push   %ebx
  int i;

  if(!uart)
80105d0a:	31 db                	xor    %ebx,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
80105d0c:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(!uart)
80105d0f:	8b 15 c8 a5 10 80    	mov    0x8010a5c8,%edx
80105d15:	85 d2                	test   %edx,%edx
80105d17:	75 1e                	jne    80105d37 <uartputc+0x37>
80105d19:	eb 2c                	jmp    80105d47 <uartputc+0x47>
80105d1b:	90                   	nop
80105d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d20:	83 c3 01             	add    $0x1,%ebx
    microdelay(10);
80105d23:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105d2a:	e8 41 ca ff ff       	call   80102770 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d2f:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80105d35:	74 07                	je     80105d3e <uartputc+0x3e>
80105d37:	89 f2                	mov    %esi,%edx
80105d39:	ec                   	in     (%dx),%al
80105d3a:	a8 20                	test   $0x20,%al
80105d3c:	74 e2                	je     80105d20 <uartputc+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d3e:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d43:	8b 45 08             	mov    0x8(%ebp),%eax
80105d46:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105d47:	83 c4 10             	add    $0x10,%esp
80105d4a:	5b                   	pop    %ebx
80105d4b:	5e                   	pop    %esi
80105d4c:	5d                   	pop    %ebp
80105d4d:	c3                   	ret    
80105d4e:	66 90                	xchg   %ax,%ax

80105d50 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105d50:	55                   	push   %ebp
80105d51:	31 c9                	xor    %ecx,%ecx
80105d53:	89 e5                	mov    %esp,%ebp
80105d55:	89 c8                	mov    %ecx,%eax
80105d57:	57                   	push   %edi
80105d58:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105d5d:	56                   	push   %esi
80105d5e:	89 fa                	mov    %edi,%edx
80105d60:	53                   	push   %ebx
80105d61:	83 ec 1c             	sub    $0x1c,%esp
80105d64:	ee                   	out    %al,(%dx)
80105d65:	bb fb 03 00 00       	mov    $0x3fb,%ebx
80105d6a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d6f:	89 da                	mov    %ebx,%edx
80105d71:	ee                   	out    %al,(%dx)
80105d72:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d77:	b2 f8                	mov    $0xf8,%dl
80105d79:	ee                   	out    %al,(%dx)
80105d7a:	be f9 03 00 00       	mov    $0x3f9,%esi
80105d7f:	89 c8                	mov    %ecx,%eax
80105d81:	89 f2                	mov    %esi,%edx
80105d83:	ee                   	out    %al,(%dx)
80105d84:	b8 03 00 00 00       	mov    $0x3,%eax
80105d89:	89 da                	mov    %ebx,%edx
80105d8b:	ee                   	out    %al,(%dx)
80105d8c:	b2 fc                	mov    $0xfc,%dl
80105d8e:	89 c8                	mov    %ecx,%eax
80105d90:	ee                   	out    %al,(%dx)
80105d91:	b8 01 00 00 00       	mov    $0x1,%eax
80105d96:	89 f2                	mov    %esi,%edx
80105d98:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d99:	b2 fd                	mov    $0xfd,%dl
80105d9b:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105d9c:	3c ff                	cmp    $0xff,%al
80105d9e:	74 55                	je     80105df5 <uartinit+0xa5>
    return;
  uart = 1;
80105da0:	c7 05 c8 a5 10 80 01 	movl   $0x1,0x8010a5c8
80105da7:	00 00 00 
80105daa:	89 fa                	mov    %edi,%edx
80105dac:	ec                   	in     (%dx),%al
80105dad:	b2 f8                	mov    $0xf8,%dl
80105daf:	ec                   	in     (%dx),%al
  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
80105db0:	bb 50 7a 10 80       	mov    $0x80107a50,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
80105db5:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105dbc:	e8 ff d4 ff ff       	call   801032c0 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105dc1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105dc8:	00 
80105dc9:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105dd0:	e8 7b c4 ff ff       	call   80102250 <ioapicenable>
80105dd5:	b8 78 00 00 00       	mov    $0x78,%eax
80105dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
80105de0:	0f be c0             	movsbl %al,%eax
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105de3:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
80105de6:	89 04 24             	mov    %eax,(%esp)
80105de9:	e8 12 ff ff ff       	call   80105d00 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105dee:	0f b6 03             	movzbl (%ebx),%eax
80105df1:	84 c0                	test   %al,%al
80105df3:	75 eb                	jne    80105de0 <uartinit+0x90>
    uartputc(*p);
}
80105df5:	83 c4 1c             	add    $0x1c,%esp
80105df8:	5b                   	pop    %ebx
80105df9:	5e                   	pop    %esi
80105dfa:	5f                   	pop    %edi
80105dfb:	5d                   	pop    %ebp
80105dfc:	c3                   	ret    
80105dfd:	00 00                	add    %al,(%eax)
	...

80105e00 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e00:	6a 00                	push   $0x0
  pushl $0
80105e02:	6a 00                	push   $0x0
  jmp alltraps
80105e04:	e9 47 fb ff ff       	jmp    80105950 <alltraps>

80105e09 <vector1>:
.globl vector1
vector1:
  pushl $0
80105e09:	6a 00                	push   $0x0
  pushl $1
80105e0b:	6a 01                	push   $0x1
  jmp alltraps
80105e0d:	e9 3e fb ff ff       	jmp    80105950 <alltraps>

80105e12 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e12:	6a 00                	push   $0x0
  pushl $2
80105e14:	6a 02                	push   $0x2
  jmp alltraps
80105e16:	e9 35 fb ff ff       	jmp    80105950 <alltraps>

80105e1b <vector3>:
.globl vector3
vector3:
  pushl $0
80105e1b:	6a 00                	push   $0x0
  pushl $3
80105e1d:	6a 03                	push   $0x3
  jmp alltraps
80105e1f:	e9 2c fb ff ff       	jmp    80105950 <alltraps>

80105e24 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e24:	6a 00                	push   $0x0
  pushl $4
80105e26:	6a 04                	push   $0x4
  jmp alltraps
80105e28:	e9 23 fb ff ff       	jmp    80105950 <alltraps>

80105e2d <vector5>:
.globl vector5
vector5:
  pushl $0
80105e2d:	6a 00                	push   $0x0
  pushl $5
80105e2f:	6a 05                	push   $0x5
  jmp alltraps
80105e31:	e9 1a fb ff ff       	jmp    80105950 <alltraps>

80105e36 <vector6>:
.globl vector6
vector6:
  pushl $0
80105e36:	6a 00                	push   $0x0
  pushl $6
80105e38:	6a 06                	push   $0x6
  jmp alltraps
80105e3a:	e9 11 fb ff ff       	jmp    80105950 <alltraps>

80105e3f <vector7>:
.globl vector7
vector7:
  pushl $0
80105e3f:	6a 00                	push   $0x0
  pushl $7
80105e41:	6a 07                	push   $0x7
  jmp alltraps
80105e43:	e9 08 fb ff ff       	jmp    80105950 <alltraps>

80105e48 <vector8>:
.globl vector8
vector8:
  pushl $8
80105e48:	6a 08                	push   $0x8
  jmp alltraps
80105e4a:	e9 01 fb ff ff       	jmp    80105950 <alltraps>

80105e4f <vector9>:
.globl vector9
vector9:
  pushl $0
80105e4f:	6a 00                	push   $0x0
  pushl $9
80105e51:	6a 09                	push   $0x9
  jmp alltraps
80105e53:	e9 f8 fa ff ff       	jmp    80105950 <alltraps>

80105e58 <vector10>:
.globl vector10
vector10:
  pushl $10
80105e58:	6a 0a                	push   $0xa
  jmp alltraps
80105e5a:	e9 f1 fa ff ff       	jmp    80105950 <alltraps>

80105e5f <vector11>:
.globl vector11
vector11:
  pushl $11
80105e5f:	6a 0b                	push   $0xb
  jmp alltraps
80105e61:	e9 ea fa ff ff       	jmp    80105950 <alltraps>

80105e66 <vector12>:
.globl vector12
vector12:
  pushl $12
80105e66:	6a 0c                	push   $0xc
  jmp alltraps
80105e68:	e9 e3 fa ff ff       	jmp    80105950 <alltraps>

80105e6d <vector13>:
.globl vector13
vector13:
  pushl $13
80105e6d:	6a 0d                	push   $0xd
  jmp alltraps
80105e6f:	e9 dc fa ff ff       	jmp    80105950 <alltraps>

80105e74 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e74:	6a 0e                	push   $0xe
  jmp alltraps
80105e76:	e9 d5 fa ff ff       	jmp    80105950 <alltraps>

80105e7b <vector15>:
.globl vector15
vector15:
  pushl $0
80105e7b:	6a 00                	push   $0x0
  pushl $15
80105e7d:	6a 0f                	push   $0xf
  jmp alltraps
80105e7f:	e9 cc fa ff ff       	jmp    80105950 <alltraps>

80105e84 <vector16>:
.globl vector16
vector16:
  pushl $0
80105e84:	6a 00                	push   $0x0
  pushl $16
80105e86:	6a 10                	push   $0x10
  jmp alltraps
80105e88:	e9 c3 fa ff ff       	jmp    80105950 <alltraps>

80105e8d <vector17>:
.globl vector17
vector17:
  pushl $17
80105e8d:	6a 11                	push   $0x11
  jmp alltraps
80105e8f:	e9 bc fa ff ff       	jmp    80105950 <alltraps>

80105e94 <vector18>:
.globl vector18
vector18:
  pushl $0
80105e94:	6a 00                	push   $0x0
  pushl $18
80105e96:	6a 12                	push   $0x12
  jmp alltraps
80105e98:	e9 b3 fa ff ff       	jmp    80105950 <alltraps>

80105e9d <vector19>:
.globl vector19
vector19:
  pushl $0
80105e9d:	6a 00                	push   $0x0
  pushl $19
80105e9f:	6a 13                	push   $0x13
  jmp alltraps
80105ea1:	e9 aa fa ff ff       	jmp    80105950 <alltraps>

80105ea6 <vector20>:
.globl vector20
vector20:
  pushl $0
80105ea6:	6a 00                	push   $0x0
  pushl $20
80105ea8:	6a 14                	push   $0x14
  jmp alltraps
80105eaa:	e9 a1 fa ff ff       	jmp    80105950 <alltraps>

80105eaf <vector21>:
.globl vector21
vector21:
  pushl $0
80105eaf:	6a 00                	push   $0x0
  pushl $21
80105eb1:	6a 15                	push   $0x15
  jmp alltraps
80105eb3:	e9 98 fa ff ff       	jmp    80105950 <alltraps>

80105eb8 <vector22>:
.globl vector22
vector22:
  pushl $0
80105eb8:	6a 00                	push   $0x0
  pushl $22
80105eba:	6a 16                	push   $0x16
  jmp alltraps
80105ebc:	e9 8f fa ff ff       	jmp    80105950 <alltraps>

80105ec1 <vector23>:
.globl vector23
vector23:
  pushl $0
80105ec1:	6a 00                	push   $0x0
  pushl $23
80105ec3:	6a 17                	push   $0x17
  jmp alltraps
80105ec5:	e9 86 fa ff ff       	jmp    80105950 <alltraps>

80105eca <vector24>:
.globl vector24
vector24:
  pushl $0
80105eca:	6a 00                	push   $0x0
  pushl $24
80105ecc:	6a 18                	push   $0x18
  jmp alltraps
80105ece:	e9 7d fa ff ff       	jmp    80105950 <alltraps>

80105ed3 <vector25>:
.globl vector25
vector25:
  pushl $0
80105ed3:	6a 00                	push   $0x0
  pushl $25
80105ed5:	6a 19                	push   $0x19
  jmp alltraps
80105ed7:	e9 74 fa ff ff       	jmp    80105950 <alltraps>

80105edc <vector26>:
.globl vector26
vector26:
  pushl $0
80105edc:	6a 00                	push   $0x0
  pushl $26
80105ede:	6a 1a                	push   $0x1a
  jmp alltraps
80105ee0:	e9 6b fa ff ff       	jmp    80105950 <alltraps>

80105ee5 <vector27>:
.globl vector27
vector27:
  pushl $0
80105ee5:	6a 00                	push   $0x0
  pushl $27
80105ee7:	6a 1b                	push   $0x1b
  jmp alltraps
80105ee9:	e9 62 fa ff ff       	jmp    80105950 <alltraps>

80105eee <vector28>:
.globl vector28
vector28:
  pushl $0
80105eee:	6a 00                	push   $0x0
  pushl $28
80105ef0:	6a 1c                	push   $0x1c
  jmp alltraps
80105ef2:	e9 59 fa ff ff       	jmp    80105950 <alltraps>

80105ef7 <vector29>:
.globl vector29
vector29:
  pushl $0
80105ef7:	6a 00                	push   $0x0
  pushl $29
80105ef9:	6a 1d                	push   $0x1d
  jmp alltraps
80105efb:	e9 50 fa ff ff       	jmp    80105950 <alltraps>

80105f00 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f00:	6a 00                	push   $0x0
  pushl $30
80105f02:	6a 1e                	push   $0x1e
  jmp alltraps
80105f04:	e9 47 fa ff ff       	jmp    80105950 <alltraps>

80105f09 <vector31>:
.globl vector31
vector31:
  pushl $0
80105f09:	6a 00                	push   $0x0
  pushl $31
80105f0b:	6a 1f                	push   $0x1f
  jmp alltraps
80105f0d:	e9 3e fa ff ff       	jmp    80105950 <alltraps>

80105f12 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f12:	6a 00                	push   $0x0
  pushl $32
80105f14:	6a 20                	push   $0x20
  jmp alltraps
80105f16:	e9 35 fa ff ff       	jmp    80105950 <alltraps>

80105f1b <vector33>:
.globl vector33
vector33:
  pushl $0
80105f1b:	6a 00                	push   $0x0
  pushl $33
80105f1d:	6a 21                	push   $0x21
  jmp alltraps
80105f1f:	e9 2c fa ff ff       	jmp    80105950 <alltraps>

80105f24 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f24:	6a 00                	push   $0x0
  pushl $34
80105f26:	6a 22                	push   $0x22
  jmp alltraps
80105f28:	e9 23 fa ff ff       	jmp    80105950 <alltraps>

80105f2d <vector35>:
.globl vector35
vector35:
  pushl $0
80105f2d:	6a 00                	push   $0x0
  pushl $35
80105f2f:	6a 23                	push   $0x23
  jmp alltraps
80105f31:	e9 1a fa ff ff       	jmp    80105950 <alltraps>

80105f36 <vector36>:
.globl vector36
vector36:
  pushl $0
80105f36:	6a 00                	push   $0x0
  pushl $36
80105f38:	6a 24                	push   $0x24
  jmp alltraps
80105f3a:	e9 11 fa ff ff       	jmp    80105950 <alltraps>

80105f3f <vector37>:
.globl vector37
vector37:
  pushl $0
80105f3f:	6a 00                	push   $0x0
  pushl $37
80105f41:	6a 25                	push   $0x25
  jmp alltraps
80105f43:	e9 08 fa ff ff       	jmp    80105950 <alltraps>

80105f48 <vector38>:
.globl vector38
vector38:
  pushl $0
80105f48:	6a 00                	push   $0x0
  pushl $38
80105f4a:	6a 26                	push   $0x26
  jmp alltraps
80105f4c:	e9 ff f9 ff ff       	jmp    80105950 <alltraps>

80105f51 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f51:	6a 00                	push   $0x0
  pushl $39
80105f53:	6a 27                	push   $0x27
  jmp alltraps
80105f55:	e9 f6 f9 ff ff       	jmp    80105950 <alltraps>

80105f5a <vector40>:
.globl vector40
vector40:
  pushl $0
80105f5a:	6a 00                	push   $0x0
  pushl $40
80105f5c:	6a 28                	push   $0x28
  jmp alltraps
80105f5e:	e9 ed f9 ff ff       	jmp    80105950 <alltraps>

80105f63 <vector41>:
.globl vector41
vector41:
  pushl $0
80105f63:	6a 00                	push   $0x0
  pushl $41
80105f65:	6a 29                	push   $0x29
  jmp alltraps
80105f67:	e9 e4 f9 ff ff       	jmp    80105950 <alltraps>

80105f6c <vector42>:
.globl vector42
vector42:
  pushl $0
80105f6c:	6a 00                	push   $0x0
  pushl $42
80105f6e:	6a 2a                	push   $0x2a
  jmp alltraps
80105f70:	e9 db f9 ff ff       	jmp    80105950 <alltraps>

80105f75 <vector43>:
.globl vector43
vector43:
  pushl $0
80105f75:	6a 00                	push   $0x0
  pushl $43
80105f77:	6a 2b                	push   $0x2b
  jmp alltraps
80105f79:	e9 d2 f9 ff ff       	jmp    80105950 <alltraps>

80105f7e <vector44>:
.globl vector44
vector44:
  pushl $0
80105f7e:	6a 00                	push   $0x0
  pushl $44
80105f80:	6a 2c                	push   $0x2c
  jmp alltraps
80105f82:	e9 c9 f9 ff ff       	jmp    80105950 <alltraps>

80105f87 <vector45>:
.globl vector45
vector45:
  pushl $0
80105f87:	6a 00                	push   $0x0
  pushl $45
80105f89:	6a 2d                	push   $0x2d
  jmp alltraps
80105f8b:	e9 c0 f9 ff ff       	jmp    80105950 <alltraps>

80105f90 <vector46>:
.globl vector46
vector46:
  pushl $0
80105f90:	6a 00                	push   $0x0
  pushl $46
80105f92:	6a 2e                	push   $0x2e
  jmp alltraps
80105f94:	e9 b7 f9 ff ff       	jmp    80105950 <alltraps>

80105f99 <vector47>:
.globl vector47
vector47:
  pushl $0
80105f99:	6a 00                	push   $0x0
  pushl $47
80105f9b:	6a 2f                	push   $0x2f
  jmp alltraps
80105f9d:	e9 ae f9 ff ff       	jmp    80105950 <alltraps>

80105fa2 <vector48>:
.globl vector48
vector48:
  pushl $0
80105fa2:	6a 00                	push   $0x0
  pushl $48
80105fa4:	6a 30                	push   $0x30
  jmp alltraps
80105fa6:	e9 a5 f9 ff ff       	jmp    80105950 <alltraps>

80105fab <vector49>:
.globl vector49
vector49:
  pushl $0
80105fab:	6a 00                	push   $0x0
  pushl $49
80105fad:	6a 31                	push   $0x31
  jmp alltraps
80105faf:	e9 9c f9 ff ff       	jmp    80105950 <alltraps>

80105fb4 <vector50>:
.globl vector50
vector50:
  pushl $0
80105fb4:	6a 00                	push   $0x0
  pushl $50
80105fb6:	6a 32                	push   $0x32
  jmp alltraps
80105fb8:	e9 93 f9 ff ff       	jmp    80105950 <alltraps>

80105fbd <vector51>:
.globl vector51
vector51:
  pushl $0
80105fbd:	6a 00                	push   $0x0
  pushl $51
80105fbf:	6a 33                	push   $0x33
  jmp alltraps
80105fc1:	e9 8a f9 ff ff       	jmp    80105950 <alltraps>

80105fc6 <vector52>:
.globl vector52
vector52:
  pushl $0
80105fc6:	6a 00                	push   $0x0
  pushl $52
80105fc8:	6a 34                	push   $0x34
  jmp alltraps
80105fca:	e9 81 f9 ff ff       	jmp    80105950 <alltraps>

80105fcf <vector53>:
.globl vector53
vector53:
  pushl $0
80105fcf:	6a 00                	push   $0x0
  pushl $53
80105fd1:	6a 35                	push   $0x35
  jmp alltraps
80105fd3:	e9 78 f9 ff ff       	jmp    80105950 <alltraps>

80105fd8 <vector54>:
.globl vector54
vector54:
  pushl $0
80105fd8:	6a 00                	push   $0x0
  pushl $54
80105fda:	6a 36                	push   $0x36
  jmp alltraps
80105fdc:	e9 6f f9 ff ff       	jmp    80105950 <alltraps>

80105fe1 <vector55>:
.globl vector55
vector55:
  pushl $0
80105fe1:	6a 00                	push   $0x0
  pushl $55
80105fe3:	6a 37                	push   $0x37
  jmp alltraps
80105fe5:	e9 66 f9 ff ff       	jmp    80105950 <alltraps>

80105fea <vector56>:
.globl vector56
vector56:
  pushl $0
80105fea:	6a 00                	push   $0x0
  pushl $56
80105fec:	6a 38                	push   $0x38
  jmp alltraps
80105fee:	e9 5d f9 ff ff       	jmp    80105950 <alltraps>

80105ff3 <vector57>:
.globl vector57
vector57:
  pushl $0
80105ff3:	6a 00                	push   $0x0
  pushl $57
80105ff5:	6a 39                	push   $0x39
  jmp alltraps
80105ff7:	e9 54 f9 ff ff       	jmp    80105950 <alltraps>

80105ffc <vector58>:
.globl vector58
vector58:
  pushl $0
80105ffc:	6a 00                	push   $0x0
  pushl $58
80105ffe:	6a 3a                	push   $0x3a
  jmp alltraps
80106000:	e9 4b f9 ff ff       	jmp    80105950 <alltraps>

80106005 <vector59>:
.globl vector59
vector59:
  pushl $0
80106005:	6a 00                	push   $0x0
  pushl $59
80106007:	6a 3b                	push   $0x3b
  jmp alltraps
80106009:	e9 42 f9 ff ff       	jmp    80105950 <alltraps>

8010600e <vector60>:
.globl vector60
vector60:
  pushl $0
8010600e:	6a 00                	push   $0x0
  pushl $60
80106010:	6a 3c                	push   $0x3c
  jmp alltraps
80106012:	e9 39 f9 ff ff       	jmp    80105950 <alltraps>

80106017 <vector61>:
.globl vector61
vector61:
  pushl $0
80106017:	6a 00                	push   $0x0
  pushl $61
80106019:	6a 3d                	push   $0x3d
  jmp alltraps
8010601b:	e9 30 f9 ff ff       	jmp    80105950 <alltraps>

80106020 <vector62>:
.globl vector62
vector62:
  pushl $0
80106020:	6a 00                	push   $0x0
  pushl $62
80106022:	6a 3e                	push   $0x3e
  jmp alltraps
80106024:	e9 27 f9 ff ff       	jmp    80105950 <alltraps>

80106029 <vector63>:
.globl vector63
vector63:
  pushl $0
80106029:	6a 00                	push   $0x0
  pushl $63
8010602b:	6a 3f                	push   $0x3f
  jmp alltraps
8010602d:	e9 1e f9 ff ff       	jmp    80105950 <alltraps>

80106032 <vector64>:
.globl vector64
vector64:
  pushl $0
80106032:	6a 00                	push   $0x0
  pushl $64
80106034:	6a 40                	push   $0x40
  jmp alltraps
80106036:	e9 15 f9 ff ff       	jmp    80105950 <alltraps>

8010603b <vector65>:
.globl vector65
vector65:
  pushl $0
8010603b:	6a 00                	push   $0x0
  pushl $65
8010603d:	6a 41                	push   $0x41
  jmp alltraps
8010603f:	e9 0c f9 ff ff       	jmp    80105950 <alltraps>

80106044 <vector66>:
.globl vector66
vector66:
  pushl $0
80106044:	6a 00                	push   $0x0
  pushl $66
80106046:	6a 42                	push   $0x42
  jmp alltraps
80106048:	e9 03 f9 ff ff       	jmp    80105950 <alltraps>

8010604d <vector67>:
.globl vector67
vector67:
  pushl $0
8010604d:	6a 00                	push   $0x0
  pushl $67
8010604f:	6a 43                	push   $0x43
  jmp alltraps
80106051:	e9 fa f8 ff ff       	jmp    80105950 <alltraps>

80106056 <vector68>:
.globl vector68
vector68:
  pushl $0
80106056:	6a 00                	push   $0x0
  pushl $68
80106058:	6a 44                	push   $0x44
  jmp alltraps
8010605a:	e9 f1 f8 ff ff       	jmp    80105950 <alltraps>

8010605f <vector69>:
.globl vector69
vector69:
  pushl $0
8010605f:	6a 00                	push   $0x0
  pushl $69
80106061:	6a 45                	push   $0x45
  jmp alltraps
80106063:	e9 e8 f8 ff ff       	jmp    80105950 <alltraps>

80106068 <vector70>:
.globl vector70
vector70:
  pushl $0
80106068:	6a 00                	push   $0x0
  pushl $70
8010606a:	6a 46                	push   $0x46
  jmp alltraps
8010606c:	e9 df f8 ff ff       	jmp    80105950 <alltraps>

80106071 <vector71>:
.globl vector71
vector71:
  pushl $0
80106071:	6a 00                	push   $0x0
  pushl $71
80106073:	6a 47                	push   $0x47
  jmp alltraps
80106075:	e9 d6 f8 ff ff       	jmp    80105950 <alltraps>

8010607a <vector72>:
.globl vector72
vector72:
  pushl $0
8010607a:	6a 00                	push   $0x0
  pushl $72
8010607c:	6a 48                	push   $0x48
  jmp alltraps
8010607e:	e9 cd f8 ff ff       	jmp    80105950 <alltraps>

80106083 <vector73>:
.globl vector73
vector73:
  pushl $0
80106083:	6a 00                	push   $0x0
  pushl $73
80106085:	6a 49                	push   $0x49
  jmp alltraps
80106087:	e9 c4 f8 ff ff       	jmp    80105950 <alltraps>

8010608c <vector74>:
.globl vector74
vector74:
  pushl $0
8010608c:	6a 00                	push   $0x0
  pushl $74
8010608e:	6a 4a                	push   $0x4a
  jmp alltraps
80106090:	e9 bb f8 ff ff       	jmp    80105950 <alltraps>

80106095 <vector75>:
.globl vector75
vector75:
  pushl $0
80106095:	6a 00                	push   $0x0
  pushl $75
80106097:	6a 4b                	push   $0x4b
  jmp alltraps
80106099:	e9 b2 f8 ff ff       	jmp    80105950 <alltraps>

8010609e <vector76>:
.globl vector76
vector76:
  pushl $0
8010609e:	6a 00                	push   $0x0
  pushl $76
801060a0:	6a 4c                	push   $0x4c
  jmp alltraps
801060a2:	e9 a9 f8 ff ff       	jmp    80105950 <alltraps>

801060a7 <vector77>:
.globl vector77
vector77:
  pushl $0
801060a7:	6a 00                	push   $0x0
  pushl $77
801060a9:	6a 4d                	push   $0x4d
  jmp alltraps
801060ab:	e9 a0 f8 ff ff       	jmp    80105950 <alltraps>

801060b0 <vector78>:
.globl vector78
vector78:
  pushl $0
801060b0:	6a 00                	push   $0x0
  pushl $78
801060b2:	6a 4e                	push   $0x4e
  jmp alltraps
801060b4:	e9 97 f8 ff ff       	jmp    80105950 <alltraps>

801060b9 <vector79>:
.globl vector79
vector79:
  pushl $0
801060b9:	6a 00                	push   $0x0
  pushl $79
801060bb:	6a 4f                	push   $0x4f
  jmp alltraps
801060bd:	e9 8e f8 ff ff       	jmp    80105950 <alltraps>

801060c2 <vector80>:
.globl vector80
vector80:
  pushl $0
801060c2:	6a 00                	push   $0x0
  pushl $80
801060c4:	6a 50                	push   $0x50
  jmp alltraps
801060c6:	e9 85 f8 ff ff       	jmp    80105950 <alltraps>

801060cb <vector81>:
.globl vector81
vector81:
  pushl $0
801060cb:	6a 00                	push   $0x0
  pushl $81
801060cd:	6a 51                	push   $0x51
  jmp alltraps
801060cf:	e9 7c f8 ff ff       	jmp    80105950 <alltraps>

801060d4 <vector82>:
.globl vector82
vector82:
  pushl $0
801060d4:	6a 00                	push   $0x0
  pushl $82
801060d6:	6a 52                	push   $0x52
  jmp alltraps
801060d8:	e9 73 f8 ff ff       	jmp    80105950 <alltraps>

801060dd <vector83>:
.globl vector83
vector83:
  pushl $0
801060dd:	6a 00                	push   $0x0
  pushl $83
801060df:	6a 53                	push   $0x53
  jmp alltraps
801060e1:	e9 6a f8 ff ff       	jmp    80105950 <alltraps>

801060e6 <vector84>:
.globl vector84
vector84:
  pushl $0
801060e6:	6a 00                	push   $0x0
  pushl $84
801060e8:	6a 54                	push   $0x54
  jmp alltraps
801060ea:	e9 61 f8 ff ff       	jmp    80105950 <alltraps>

801060ef <vector85>:
.globl vector85
vector85:
  pushl $0
801060ef:	6a 00                	push   $0x0
  pushl $85
801060f1:	6a 55                	push   $0x55
  jmp alltraps
801060f3:	e9 58 f8 ff ff       	jmp    80105950 <alltraps>

801060f8 <vector86>:
.globl vector86
vector86:
  pushl $0
801060f8:	6a 00                	push   $0x0
  pushl $86
801060fa:	6a 56                	push   $0x56
  jmp alltraps
801060fc:	e9 4f f8 ff ff       	jmp    80105950 <alltraps>

80106101 <vector87>:
.globl vector87
vector87:
  pushl $0
80106101:	6a 00                	push   $0x0
  pushl $87
80106103:	6a 57                	push   $0x57
  jmp alltraps
80106105:	e9 46 f8 ff ff       	jmp    80105950 <alltraps>

8010610a <vector88>:
.globl vector88
vector88:
  pushl $0
8010610a:	6a 00                	push   $0x0
  pushl $88
8010610c:	6a 58                	push   $0x58
  jmp alltraps
8010610e:	e9 3d f8 ff ff       	jmp    80105950 <alltraps>

80106113 <vector89>:
.globl vector89
vector89:
  pushl $0
80106113:	6a 00                	push   $0x0
  pushl $89
80106115:	6a 59                	push   $0x59
  jmp alltraps
80106117:	e9 34 f8 ff ff       	jmp    80105950 <alltraps>

8010611c <vector90>:
.globl vector90
vector90:
  pushl $0
8010611c:	6a 00                	push   $0x0
  pushl $90
8010611e:	6a 5a                	push   $0x5a
  jmp alltraps
80106120:	e9 2b f8 ff ff       	jmp    80105950 <alltraps>

80106125 <vector91>:
.globl vector91
vector91:
  pushl $0
80106125:	6a 00                	push   $0x0
  pushl $91
80106127:	6a 5b                	push   $0x5b
  jmp alltraps
80106129:	e9 22 f8 ff ff       	jmp    80105950 <alltraps>

8010612e <vector92>:
.globl vector92
vector92:
  pushl $0
8010612e:	6a 00                	push   $0x0
  pushl $92
80106130:	6a 5c                	push   $0x5c
  jmp alltraps
80106132:	e9 19 f8 ff ff       	jmp    80105950 <alltraps>

80106137 <vector93>:
.globl vector93
vector93:
  pushl $0
80106137:	6a 00                	push   $0x0
  pushl $93
80106139:	6a 5d                	push   $0x5d
  jmp alltraps
8010613b:	e9 10 f8 ff ff       	jmp    80105950 <alltraps>

80106140 <vector94>:
.globl vector94
vector94:
  pushl $0
80106140:	6a 00                	push   $0x0
  pushl $94
80106142:	6a 5e                	push   $0x5e
  jmp alltraps
80106144:	e9 07 f8 ff ff       	jmp    80105950 <alltraps>

80106149 <vector95>:
.globl vector95
vector95:
  pushl $0
80106149:	6a 00                	push   $0x0
  pushl $95
8010614b:	6a 5f                	push   $0x5f
  jmp alltraps
8010614d:	e9 fe f7 ff ff       	jmp    80105950 <alltraps>

80106152 <vector96>:
.globl vector96
vector96:
  pushl $0
80106152:	6a 00                	push   $0x0
  pushl $96
80106154:	6a 60                	push   $0x60
  jmp alltraps
80106156:	e9 f5 f7 ff ff       	jmp    80105950 <alltraps>

8010615b <vector97>:
.globl vector97
vector97:
  pushl $0
8010615b:	6a 00                	push   $0x0
  pushl $97
8010615d:	6a 61                	push   $0x61
  jmp alltraps
8010615f:	e9 ec f7 ff ff       	jmp    80105950 <alltraps>

80106164 <vector98>:
.globl vector98
vector98:
  pushl $0
80106164:	6a 00                	push   $0x0
  pushl $98
80106166:	6a 62                	push   $0x62
  jmp alltraps
80106168:	e9 e3 f7 ff ff       	jmp    80105950 <alltraps>

8010616d <vector99>:
.globl vector99
vector99:
  pushl $0
8010616d:	6a 00                	push   $0x0
  pushl $99
8010616f:	6a 63                	push   $0x63
  jmp alltraps
80106171:	e9 da f7 ff ff       	jmp    80105950 <alltraps>

80106176 <vector100>:
.globl vector100
vector100:
  pushl $0
80106176:	6a 00                	push   $0x0
  pushl $100
80106178:	6a 64                	push   $0x64
  jmp alltraps
8010617a:	e9 d1 f7 ff ff       	jmp    80105950 <alltraps>

8010617f <vector101>:
.globl vector101
vector101:
  pushl $0
8010617f:	6a 00                	push   $0x0
  pushl $101
80106181:	6a 65                	push   $0x65
  jmp alltraps
80106183:	e9 c8 f7 ff ff       	jmp    80105950 <alltraps>

80106188 <vector102>:
.globl vector102
vector102:
  pushl $0
80106188:	6a 00                	push   $0x0
  pushl $102
8010618a:	6a 66                	push   $0x66
  jmp alltraps
8010618c:	e9 bf f7 ff ff       	jmp    80105950 <alltraps>

80106191 <vector103>:
.globl vector103
vector103:
  pushl $0
80106191:	6a 00                	push   $0x0
  pushl $103
80106193:	6a 67                	push   $0x67
  jmp alltraps
80106195:	e9 b6 f7 ff ff       	jmp    80105950 <alltraps>

8010619a <vector104>:
.globl vector104
vector104:
  pushl $0
8010619a:	6a 00                	push   $0x0
  pushl $104
8010619c:	6a 68                	push   $0x68
  jmp alltraps
8010619e:	e9 ad f7 ff ff       	jmp    80105950 <alltraps>

801061a3 <vector105>:
.globl vector105
vector105:
  pushl $0
801061a3:	6a 00                	push   $0x0
  pushl $105
801061a5:	6a 69                	push   $0x69
  jmp alltraps
801061a7:	e9 a4 f7 ff ff       	jmp    80105950 <alltraps>

801061ac <vector106>:
.globl vector106
vector106:
  pushl $0
801061ac:	6a 00                	push   $0x0
  pushl $106
801061ae:	6a 6a                	push   $0x6a
  jmp alltraps
801061b0:	e9 9b f7 ff ff       	jmp    80105950 <alltraps>

801061b5 <vector107>:
.globl vector107
vector107:
  pushl $0
801061b5:	6a 00                	push   $0x0
  pushl $107
801061b7:	6a 6b                	push   $0x6b
  jmp alltraps
801061b9:	e9 92 f7 ff ff       	jmp    80105950 <alltraps>

801061be <vector108>:
.globl vector108
vector108:
  pushl $0
801061be:	6a 00                	push   $0x0
  pushl $108
801061c0:	6a 6c                	push   $0x6c
  jmp alltraps
801061c2:	e9 89 f7 ff ff       	jmp    80105950 <alltraps>

801061c7 <vector109>:
.globl vector109
vector109:
  pushl $0
801061c7:	6a 00                	push   $0x0
  pushl $109
801061c9:	6a 6d                	push   $0x6d
  jmp alltraps
801061cb:	e9 80 f7 ff ff       	jmp    80105950 <alltraps>

801061d0 <vector110>:
.globl vector110
vector110:
  pushl $0
801061d0:	6a 00                	push   $0x0
  pushl $110
801061d2:	6a 6e                	push   $0x6e
  jmp alltraps
801061d4:	e9 77 f7 ff ff       	jmp    80105950 <alltraps>

801061d9 <vector111>:
.globl vector111
vector111:
  pushl $0
801061d9:	6a 00                	push   $0x0
  pushl $111
801061db:	6a 6f                	push   $0x6f
  jmp alltraps
801061dd:	e9 6e f7 ff ff       	jmp    80105950 <alltraps>

801061e2 <vector112>:
.globl vector112
vector112:
  pushl $0
801061e2:	6a 00                	push   $0x0
  pushl $112
801061e4:	6a 70                	push   $0x70
  jmp alltraps
801061e6:	e9 65 f7 ff ff       	jmp    80105950 <alltraps>

801061eb <vector113>:
.globl vector113
vector113:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $113
801061ed:	6a 71                	push   $0x71
  jmp alltraps
801061ef:	e9 5c f7 ff ff       	jmp    80105950 <alltraps>

801061f4 <vector114>:
.globl vector114
vector114:
  pushl $0
801061f4:	6a 00                	push   $0x0
  pushl $114
801061f6:	6a 72                	push   $0x72
  jmp alltraps
801061f8:	e9 53 f7 ff ff       	jmp    80105950 <alltraps>

801061fd <vector115>:
.globl vector115
vector115:
  pushl $0
801061fd:	6a 00                	push   $0x0
  pushl $115
801061ff:	6a 73                	push   $0x73
  jmp alltraps
80106201:	e9 4a f7 ff ff       	jmp    80105950 <alltraps>

80106206 <vector116>:
.globl vector116
vector116:
  pushl $0
80106206:	6a 00                	push   $0x0
  pushl $116
80106208:	6a 74                	push   $0x74
  jmp alltraps
8010620a:	e9 41 f7 ff ff       	jmp    80105950 <alltraps>

8010620f <vector117>:
.globl vector117
vector117:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $117
80106211:	6a 75                	push   $0x75
  jmp alltraps
80106213:	e9 38 f7 ff ff       	jmp    80105950 <alltraps>

80106218 <vector118>:
.globl vector118
vector118:
  pushl $0
80106218:	6a 00                	push   $0x0
  pushl $118
8010621a:	6a 76                	push   $0x76
  jmp alltraps
8010621c:	e9 2f f7 ff ff       	jmp    80105950 <alltraps>

80106221 <vector119>:
.globl vector119
vector119:
  pushl $0
80106221:	6a 00                	push   $0x0
  pushl $119
80106223:	6a 77                	push   $0x77
  jmp alltraps
80106225:	e9 26 f7 ff ff       	jmp    80105950 <alltraps>

8010622a <vector120>:
.globl vector120
vector120:
  pushl $0
8010622a:	6a 00                	push   $0x0
  pushl $120
8010622c:	6a 78                	push   $0x78
  jmp alltraps
8010622e:	e9 1d f7 ff ff       	jmp    80105950 <alltraps>

80106233 <vector121>:
.globl vector121
vector121:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $121
80106235:	6a 79                	push   $0x79
  jmp alltraps
80106237:	e9 14 f7 ff ff       	jmp    80105950 <alltraps>

8010623c <vector122>:
.globl vector122
vector122:
  pushl $0
8010623c:	6a 00                	push   $0x0
  pushl $122
8010623e:	6a 7a                	push   $0x7a
  jmp alltraps
80106240:	e9 0b f7 ff ff       	jmp    80105950 <alltraps>

80106245 <vector123>:
.globl vector123
vector123:
  pushl $0
80106245:	6a 00                	push   $0x0
  pushl $123
80106247:	6a 7b                	push   $0x7b
  jmp alltraps
80106249:	e9 02 f7 ff ff       	jmp    80105950 <alltraps>

8010624e <vector124>:
.globl vector124
vector124:
  pushl $0
8010624e:	6a 00                	push   $0x0
  pushl $124
80106250:	6a 7c                	push   $0x7c
  jmp alltraps
80106252:	e9 f9 f6 ff ff       	jmp    80105950 <alltraps>

80106257 <vector125>:
.globl vector125
vector125:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $125
80106259:	6a 7d                	push   $0x7d
  jmp alltraps
8010625b:	e9 f0 f6 ff ff       	jmp    80105950 <alltraps>

80106260 <vector126>:
.globl vector126
vector126:
  pushl $0
80106260:	6a 00                	push   $0x0
  pushl $126
80106262:	6a 7e                	push   $0x7e
  jmp alltraps
80106264:	e9 e7 f6 ff ff       	jmp    80105950 <alltraps>

80106269 <vector127>:
.globl vector127
vector127:
  pushl $0
80106269:	6a 00                	push   $0x0
  pushl $127
8010626b:	6a 7f                	push   $0x7f
  jmp alltraps
8010626d:	e9 de f6 ff ff       	jmp    80105950 <alltraps>

80106272 <vector128>:
.globl vector128
vector128:
  pushl $0
80106272:	6a 00                	push   $0x0
  pushl $128
80106274:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106279:	e9 d2 f6 ff ff       	jmp    80105950 <alltraps>

8010627e <vector129>:
.globl vector129
vector129:
  pushl $0
8010627e:	6a 00                	push   $0x0
  pushl $129
80106280:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106285:	e9 c6 f6 ff ff       	jmp    80105950 <alltraps>

8010628a <vector130>:
.globl vector130
vector130:
  pushl $0
8010628a:	6a 00                	push   $0x0
  pushl $130
8010628c:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106291:	e9 ba f6 ff ff       	jmp    80105950 <alltraps>

80106296 <vector131>:
.globl vector131
vector131:
  pushl $0
80106296:	6a 00                	push   $0x0
  pushl $131
80106298:	68 83 00 00 00       	push   $0x83
  jmp alltraps
8010629d:	e9 ae f6 ff ff       	jmp    80105950 <alltraps>

801062a2 <vector132>:
.globl vector132
vector132:
  pushl $0
801062a2:	6a 00                	push   $0x0
  pushl $132
801062a4:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801062a9:	e9 a2 f6 ff ff       	jmp    80105950 <alltraps>

801062ae <vector133>:
.globl vector133
vector133:
  pushl $0
801062ae:	6a 00                	push   $0x0
  pushl $133
801062b0:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801062b5:	e9 96 f6 ff ff       	jmp    80105950 <alltraps>

801062ba <vector134>:
.globl vector134
vector134:
  pushl $0
801062ba:	6a 00                	push   $0x0
  pushl $134
801062bc:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801062c1:	e9 8a f6 ff ff       	jmp    80105950 <alltraps>

801062c6 <vector135>:
.globl vector135
vector135:
  pushl $0
801062c6:	6a 00                	push   $0x0
  pushl $135
801062c8:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801062cd:	e9 7e f6 ff ff       	jmp    80105950 <alltraps>

801062d2 <vector136>:
.globl vector136
vector136:
  pushl $0
801062d2:	6a 00                	push   $0x0
  pushl $136
801062d4:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801062d9:	e9 72 f6 ff ff       	jmp    80105950 <alltraps>

801062de <vector137>:
.globl vector137
vector137:
  pushl $0
801062de:	6a 00                	push   $0x0
  pushl $137
801062e0:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801062e5:	e9 66 f6 ff ff       	jmp    80105950 <alltraps>

801062ea <vector138>:
.globl vector138
vector138:
  pushl $0
801062ea:	6a 00                	push   $0x0
  pushl $138
801062ec:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801062f1:	e9 5a f6 ff ff       	jmp    80105950 <alltraps>

801062f6 <vector139>:
.globl vector139
vector139:
  pushl $0
801062f6:	6a 00                	push   $0x0
  pushl $139
801062f8:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801062fd:	e9 4e f6 ff ff       	jmp    80105950 <alltraps>

80106302 <vector140>:
.globl vector140
vector140:
  pushl $0
80106302:	6a 00                	push   $0x0
  pushl $140
80106304:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106309:	e9 42 f6 ff ff       	jmp    80105950 <alltraps>

8010630e <vector141>:
.globl vector141
vector141:
  pushl $0
8010630e:	6a 00                	push   $0x0
  pushl $141
80106310:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106315:	e9 36 f6 ff ff       	jmp    80105950 <alltraps>

8010631a <vector142>:
.globl vector142
vector142:
  pushl $0
8010631a:	6a 00                	push   $0x0
  pushl $142
8010631c:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106321:	e9 2a f6 ff ff       	jmp    80105950 <alltraps>

80106326 <vector143>:
.globl vector143
vector143:
  pushl $0
80106326:	6a 00                	push   $0x0
  pushl $143
80106328:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
8010632d:	e9 1e f6 ff ff       	jmp    80105950 <alltraps>

80106332 <vector144>:
.globl vector144
vector144:
  pushl $0
80106332:	6a 00                	push   $0x0
  pushl $144
80106334:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106339:	e9 12 f6 ff ff       	jmp    80105950 <alltraps>

8010633e <vector145>:
.globl vector145
vector145:
  pushl $0
8010633e:	6a 00                	push   $0x0
  pushl $145
80106340:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106345:	e9 06 f6 ff ff       	jmp    80105950 <alltraps>

8010634a <vector146>:
.globl vector146
vector146:
  pushl $0
8010634a:	6a 00                	push   $0x0
  pushl $146
8010634c:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106351:	e9 fa f5 ff ff       	jmp    80105950 <alltraps>

80106356 <vector147>:
.globl vector147
vector147:
  pushl $0
80106356:	6a 00                	push   $0x0
  pushl $147
80106358:	68 93 00 00 00       	push   $0x93
  jmp alltraps
8010635d:	e9 ee f5 ff ff       	jmp    80105950 <alltraps>

80106362 <vector148>:
.globl vector148
vector148:
  pushl $0
80106362:	6a 00                	push   $0x0
  pushl $148
80106364:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106369:	e9 e2 f5 ff ff       	jmp    80105950 <alltraps>

8010636e <vector149>:
.globl vector149
vector149:
  pushl $0
8010636e:	6a 00                	push   $0x0
  pushl $149
80106370:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106375:	e9 d6 f5 ff ff       	jmp    80105950 <alltraps>

8010637a <vector150>:
.globl vector150
vector150:
  pushl $0
8010637a:	6a 00                	push   $0x0
  pushl $150
8010637c:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106381:	e9 ca f5 ff ff       	jmp    80105950 <alltraps>

80106386 <vector151>:
.globl vector151
vector151:
  pushl $0
80106386:	6a 00                	push   $0x0
  pushl $151
80106388:	68 97 00 00 00       	push   $0x97
  jmp alltraps
8010638d:	e9 be f5 ff ff       	jmp    80105950 <alltraps>

80106392 <vector152>:
.globl vector152
vector152:
  pushl $0
80106392:	6a 00                	push   $0x0
  pushl $152
80106394:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106399:	e9 b2 f5 ff ff       	jmp    80105950 <alltraps>

8010639e <vector153>:
.globl vector153
vector153:
  pushl $0
8010639e:	6a 00                	push   $0x0
  pushl $153
801063a0:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801063a5:	e9 a6 f5 ff ff       	jmp    80105950 <alltraps>

801063aa <vector154>:
.globl vector154
vector154:
  pushl $0
801063aa:	6a 00                	push   $0x0
  pushl $154
801063ac:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801063b1:	e9 9a f5 ff ff       	jmp    80105950 <alltraps>

801063b6 <vector155>:
.globl vector155
vector155:
  pushl $0
801063b6:	6a 00                	push   $0x0
  pushl $155
801063b8:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801063bd:	e9 8e f5 ff ff       	jmp    80105950 <alltraps>

801063c2 <vector156>:
.globl vector156
vector156:
  pushl $0
801063c2:	6a 00                	push   $0x0
  pushl $156
801063c4:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801063c9:	e9 82 f5 ff ff       	jmp    80105950 <alltraps>

801063ce <vector157>:
.globl vector157
vector157:
  pushl $0
801063ce:	6a 00                	push   $0x0
  pushl $157
801063d0:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801063d5:	e9 76 f5 ff ff       	jmp    80105950 <alltraps>

801063da <vector158>:
.globl vector158
vector158:
  pushl $0
801063da:	6a 00                	push   $0x0
  pushl $158
801063dc:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801063e1:	e9 6a f5 ff ff       	jmp    80105950 <alltraps>

801063e6 <vector159>:
.globl vector159
vector159:
  pushl $0
801063e6:	6a 00                	push   $0x0
  pushl $159
801063e8:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801063ed:	e9 5e f5 ff ff       	jmp    80105950 <alltraps>

801063f2 <vector160>:
.globl vector160
vector160:
  pushl $0
801063f2:	6a 00                	push   $0x0
  pushl $160
801063f4:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801063f9:	e9 52 f5 ff ff       	jmp    80105950 <alltraps>

801063fe <vector161>:
.globl vector161
vector161:
  pushl $0
801063fe:	6a 00                	push   $0x0
  pushl $161
80106400:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106405:	e9 46 f5 ff ff       	jmp    80105950 <alltraps>

8010640a <vector162>:
.globl vector162
vector162:
  pushl $0
8010640a:	6a 00                	push   $0x0
  pushl $162
8010640c:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106411:	e9 3a f5 ff ff       	jmp    80105950 <alltraps>

80106416 <vector163>:
.globl vector163
vector163:
  pushl $0
80106416:	6a 00                	push   $0x0
  pushl $163
80106418:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
8010641d:	e9 2e f5 ff ff       	jmp    80105950 <alltraps>

80106422 <vector164>:
.globl vector164
vector164:
  pushl $0
80106422:	6a 00                	push   $0x0
  pushl $164
80106424:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106429:	e9 22 f5 ff ff       	jmp    80105950 <alltraps>

8010642e <vector165>:
.globl vector165
vector165:
  pushl $0
8010642e:	6a 00                	push   $0x0
  pushl $165
80106430:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106435:	e9 16 f5 ff ff       	jmp    80105950 <alltraps>

8010643a <vector166>:
.globl vector166
vector166:
  pushl $0
8010643a:	6a 00                	push   $0x0
  pushl $166
8010643c:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106441:	e9 0a f5 ff ff       	jmp    80105950 <alltraps>

80106446 <vector167>:
.globl vector167
vector167:
  pushl $0
80106446:	6a 00                	push   $0x0
  pushl $167
80106448:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
8010644d:	e9 fe f4 ff ff       	jmp    80105950 <alltraps>

80106452 <vector168>:
.globl vector168
vector168:
  pushl $0
80106452:	6a 00                	push   $0x0
  pushl $168
80106454:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106459:	e9 f2 f4 ff ff       	jmp    80105950 <alltraps>

8010645e <vector169>:
.globl vector169
vector169:
  pushl $0
8010645e:	6a 00                	push   $0x0
  pushl $169
80106460:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106465:	e9 e6 f4 ff ff       	jmp    80105950 <alltraps>

8010646a <vector170>:
.globl vector170
vector170:
  pushl $0
8010646a:	6a 00                	push   $0x0
  pushl $170
8010646c:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106471:	e9 da f4 ff ff       	jmp    80105950 <alltraps>

80106476 <vector171>:
.globl vector171
vector171:
  pushl $0
80106476:	6a 00                	push   $0x0
  pushl $171
80106478:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
8010647d:	e9 ce f4 ff ff       	jmp    80105950 <alltraps>

80106482 <vector172>:
.globl vector172
vector172:
  pushl $0
80106482:	6a 00                	push   $0x0
  pushl $172
80106484:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106489:	e9 c2 f4 ff ff       	jmp    80105950 <alltraps>

8010648e <vector173>:
.globl vector173
vector173:
  pushl $0
8010648e:	6a 00                	push   $0x0
  pushl $173
80106490:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106495:	e9 b6 f4 ff ff       	jmp    80105950 <alltraps>

8010649a <vector174>:
.globl vector174
vector174:
  pushl $0
8010649a:	6a 00                	push   $0x0
  pushl $174
8010649c:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801064a1:	e9 aa f4 ff ff       	jmp    80105950 <alltraps>

801064a6 <vector175>:
.globl vector175
vector175:
  pushl $0
801064a6:	6a 00                	push   $0x0
  pushl $175
801064a8:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801064ad:	e9 9e f4 ff ff       	jmp    80105950 <alltraps>

801064b2 <vector176>:
.globl vector176
vector176:
  pushl $0
801064b2:	6a 00                	push   $0x0
  pushl $176
801064b4:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801064b9:	e9 92 f4 ff ff       	jmp    80105950 <alltraps>

801064be <vector177>:
.globl vector177
vector177:
  pushl $0
801064be:	6a 00                	push   $0x0
  pushl $177
801064c0:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801064c5:	e9 86 f4 ff ff       	jmp    80105950 <alltraps>

801064ca <vector178>:
.globl vector178
vector178:
  pushl $0
801064ca:	6a 00                	push   $0x0
  pushl $178
801064cc:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801064d1:	e9 7a f4 ff ff       	jmp    80105950 <alltraps>

801064d6 <vector179>:
.globl vector179
vector179:
  pushl $0
801064d6:	6a 00                	push   $0x0
  pushl $179
801064d8:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801064dd:	e9 6e f4 ff ff       	jmp    80105950 <alltraps>

801064e2 <vector180>:
.globl vector180
vector180:
  pushl $0
801064e2:	6a 00                	push   $0x0
  pushl $180
801064e4:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801064e9:	e9 62 f4 ff ff       	jmp    80105950 <alltraps>

801064ee <vector181>:
.globl vector181
vector181:
  pushl $0
801064ee:	6a 00                	push   $0x0
  pushl $181
801064f0:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801064f5:	e9 56 f4 ff ff       	jmp    80105950 <alltraps>

801064fa <vector182>:
.globl vector182
vector182:
  pushl $0
801064fa:	6a 00                	push   $0x0
  pushl $182
801064fc:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106501:	e9 4a f4 ff ff       	jmp    80105950 <alltraps>

80106506 <vector183>:
.globl vector183
vector183:
  pushl $0
80106506:	6a 00                	push   $0x0
  pushl $183
80106508:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
8010650d:	e9 3e f4 ff ff       	jmp    80105950 <alltraps>

80106512 <vector184>:
.globl vector184
vector184:
  pushl $0
80106512:	6a 00                	push   $0x0
  pushl $184
80106514:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106519:	e9 32 f4 ff ff       	jmp    80105950 <alltraps>

8010651e <vector185>:
.globl vector185
vector185:
  pushl $0
8010651e:	6a 00                	push   $0x0
  pushl $185
80106520:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106525:	e9 26 f4 ff ff       	jmp    80105950 <alltraps>

8010652a <vector186>:
.globl vector186
vector186:
  pushl $0
8010652a:	6a 00                	push   $0x0
  pushl $186
8010652c:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106531:	e9 1a f4 ff ff       	jmp    80105950 <alltraps>

80106536 <vector187>:
.globl vector187
vector187:
  pushl $0
80106536:	6a 00                	push   $0x0
  pushl $187
80106538:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
8010653d:	e9 0e f4 ff ff       	jmp    80105950 <alltraps>

80106542 <vector188>:
.globl vector188
vector188:
  pushl $0
80106542:	6a 00                	push   $0x0
  pushl $188
80106544:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106549:	e9 02 f4 ff ff       	jmp    80105950 <alltraps>

8010654e <vector189>:
.globl vector189
vector189:
  pushl $0
8010654e:	6a 00                	push   $0x0
  pushl $189
80106550:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106555:	e9 f6 f3 ff ff       	jmp    80105950 <alltraps>

8010655a <vector190>:
.globl vector190
vector190:
  pushl $0
8010655a:	6a 00                	push   $0x0
  pushl $190
8010655c:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106561:	e9 ea f3 ff ff       	jmp    80105950 <alltraps>

80106566 <vector191>:
.globl vector191
vector191:
  pushl $0
80106566:	6a 00                	push   $0x0
  pushl $191
80106568:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
8010656d:	e9 de f3 ff ff       	jmp    80105950 <alltraps>

80106572 <vector192>:
.globl vector192
vector192:
  pushl $0
80106572:	6a 00                	push   $0x0
  pushl $192
80106574:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106579:	e9 d2 f3 ff ff       	jmp    80105950 <alltraps>

8010657e <vector193>:
.globl vector193
vector193:
  pushl $0
8010657e:	6a 00                	push   $0x0
  pushl $193
80106580:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106585:	e9 c6 f3 ff ff       	jmp    80105950 <alltraps>

8010658a <vector194>:
.globl vector194
vector194:
  pushl $0
8010658a:	6a 00                	push   $0x0
  pushl $194
8010658c:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106591:	e9 ba f3 ff ff       	jmp    80105950 <alltraps>

80106596 <vector195>:
.globl vector195
vector195:
  pushl $0
80106596:	6a 00                	push   $0x0
  pushl $195
80106598:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
8010659d:	e9 ae f3 ff ff       	jmp    80105950 <alltraps>

801065a2 <vector196>:
.globl vector196
vector196:
  pushl $0
801065a2:	6a 00                	push   $0x0
  pushl $196
801065a4:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801065a9:	e9 a2 f3 ff ff       	jmp    80105950 <alltraps>

801065ae <vector197>:
.globl vector197
vector197:
  pushl $0
801065ae:	6a 00                	push   $0x0
  pushl $197
801065b0:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801065b5:	e9 96 f3 ff ff       	jmp    80105950 <alltraps>

801065ba <vector198>:
.globl vector198
vector198:
  pushl $0
801065ba:	6a 00                	push   $0x0
  pushl $198
801065bc:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801065c1:	e9 8a f3 ff ff       	jmp    80105950 <alltraps>

801065c6 <vector199>:
.globl vector199
vector199:
  pushl $0
801065c6:	6a 00                	push   $0x0
  pushl $199
801065c8:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801065cd:	e9 7e f3 ff ff       	jmp    80105950 <alltraps>

801065d2 <vector200>:
.globl vector200
vector200:
  pushl $0
801065d2:	6a 00                	push   $0x0
  pushl $200
801065d4:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801065d9:	e9 72 f3 ff ff       	jmp    80105950 <alltraps>

801065de <vector201>:
.globl vector201
vector201:
  pushl $0
801065de:	6a 00                	push   $0x0
  pushl $201
801065e0:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801065e5:	e9 66 f3 ff ff       	jmp    80105950 <alltraps>

801065ea <vector202>:
.globl vector202
vector202:
  pushl $0
801065ea:	6a 00                	push   $0x0
  pushl $202
801065ec:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801065f1:	e9 5a f3 ff ff       	jmp    80105950 <alltraps>

801065f6 <vector203>:
.globl vector203
vector203:
  pushl $0
801065f6:	6a 00                	push   $0x0
  pushl $203
801065f8:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801065fd:	e9 4e f3 ff ff       	jmp    80105950 <alltraps>

80106602 <vector204>:
.globl vector204
vector204:
  pushl $0
80106602:	6a 00                	push   $0x0
  pushl $204
80106604:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106609:	e9 42 f3 ff ff       	jmp    80105950 <alltraps>

8010660e <vector205>:
.globl vector205
vector205:
  pushl $0
8010660e:	6a 00                	push   $0x0
  pushl $205
80106610:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106615:	e9 36 f3 ff ff       	jmp    80105950 <alltraps>

8010661a <vector206>:
.globl vector206
vector206:
  pushl $0
8010661a:	6a 00                	push   $0x0
  pushl $206
8010661c:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106621:	e9 2a f3 ff ff       	jmp    80105950 <alltraps>

80106626 <vector207>:
.globl vector207
vector207:
  pushl $0
80106626:	6a 00                	push   $0x0
  pushl $207
80106628:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
8010662d:	e9 1e f3 ff ff       	jmp    80105950 <alltraps>

80106632 <vector208>:
.globl vector208
vector208:
  pushl $0
80106632:	6a 00                	push   $0x0
  pushl $208
80106634:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106639:	e9 12 f3 ff ff       	jmp    80105950 <alltraps>

8010663e <vector209>:
.globl vector209
vector209:
  pushl $0
8010663e:	6a 00                	push   $0x0
  pushl $209
80106640:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106645:	e9 06 f3 ff ff       	jmp    80105950 <alltraps>

8010664a <vector210>:
.globl vector210
vector210:
  pushl $0
8010664a:	6a 00                	push   $0x0
  pushl $210
8010664c:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106651:	e9 fa f2 ff ff       	jmp    80105950 <alltraps>

80106656 <vector211>:
.globl vector211
vector211:
  pushl $0
80106656:	6a 00                	push   $0x0
  pushl $211
80106658:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
8010665d:	e9 ee f2 ff ff       	jmp    80105950 <alltraps>

80106662 <vector212>:
.globl vector212
vector212:
  pushl $0
80106662:	6a 00                	push   $0x0
  pushl $212
80106664:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106669:	e9 e2 f2 ff ff       	jmp    80105950 <alltraps>

8010666e <vector213>:
.globl vector213
vector213:
  pushl $0
8010666e:	6a 00                	push   $0x0
  pushl $213
80106670:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106675:	e9 d6 f2 ff ff       	jmp    80105950 <alltraps>

8010667a <vector214>:
.globl vector214
vector214:
  pushl $0
8010667a:	6a 00                	push   $0x0
  pushl $214
8010667c:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106681:	e9 ca f2 ff ff       	jmp    80105950 <alltraps>

80106686 <vector215>:
.globl vector215
vector215:
  pushl $0
80106686:	6a 00                	push   $0x0
  pushl $215
80106688:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
8010668d:	e9 be f2 ff ff       	jmp    80105950 <alltraps>

80106692 <vector216>:
.globl vector216
vector216:
  pushl $0
80106692:	6a 00                	push   $0x0
  pushl $216
80106694:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106699:	e9 b2 f2 ff ff       	jmp    80105950 <alltraps>

8010669e <vector217>:
.globl vector217
vector217:
  pushl $0
8010669e:	6a 00                	push   $0x0
  pushl $217
801066a0:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801066a5:	e9 a6 f2 ff ff       	jmp    80105950 <alltraps>

801066aa <vector218>:
.globl vector218
vector218:
  pushl $0
801066aa:	6a 00                	push   $0x0
  pushl $218
801066ac:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801066b1:	e9 9a f2 ff ff       	jmp    80105950 <alltraps>

801066b6 <vector219>:
.globl vector219
vector219:
  pushl $0
801066b6:	6a 00                	push   $0x0
  pushl $219
801066b8:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801066bd:	e9 8e f2 ff ff       	jmp    80105950 <alltraps>

801066c2 <vector220>:
.globl vector220
vector220:
  pushl $0
801066c2:	6a 00                	push   $0x0
  pushl $220
801066c4:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801066c9:	e9 82 f2 ff ff       	jmp    80105950 <alltraps>

801066ce <vector221>:
.globl vector221
vector221:
  pushl $0
801066ce:	6a 00                	push   $0x0
  pushl $221
801066d0:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801066d5:	e9 76 f2 ff ff       	jmp    80105950 <alltraps>

801066da <vector222>:
.globl vector222
vector222:
  pushl $0
801066da:	6a 00                	push   $0x0
  pushl $222
801066dc:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801066e1:	e9 6a f2 ff ff       	jmp    80105950 <alltraps>

801066e6 <vector223>:
.globl vector223
vector223:
  pushl $0
801066e6:	6a 00                	push   $0x0
  pushl $223
801066e8:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801066ed:	e9 5e f2 ff ff       	jmp    80105950 <alltraps>

801066f2 <vector224>:
.globl vector224
vector224:
  pushl $0
801066f2:	6a 00                	push   $0x0
  pushl $224
801066f4:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801066f9:	e9 52 f2 ff ff       	jmp    80105950 <alltraps>

801066fe <vector225>:
.globl vector225
vector225:
  pushl $0
801066fe:	6a 00                	push   $0x0
  pushl $225
80106700:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106705:	e9 46 f2 ff ff       	jmp    80105950 <alltraps>

8010670a <vector226>:
.globl vector226
vector226:
  pushl $0
8010670a:	6a 00                	push   $0x0
  pushl $226
8010670c:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106711:	e9 3a f2 ff ff       	jmp    80105950 <alltraps>

80106716 <vector227>:
.globl vector227
vector227:
  pushl $0
80106716:	6a 00                	push   $0x0
  pushl $227
80106718:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
8010671d:	e9 2e f2 ff ff       	jmp    80105950 <alltraps>

80106722 <vector228>:
.globl vector228
vector228:
  pushl $0
80106722:	6a 00                	push   $0x0
  pushl $228
80106724:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106729:	e9 22 f2 ff ff       	jmp    80105950 <alltraps>

8010672e <vector229>:
.globl vector229
vector229:
  pushl $0
8010672e:	6a 00                	push   $0x0
  pushl $229
80106730:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106735:	e9 16 f2 ff ff       	jmp    80105950 <alltraps>

8010673a <vector230>:
.globl vector230
vector230:
  pushl $0
8010673a:	6a 00                	push   $0x0
  pushl $230
8010673c:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106741:	e9 0a f2 ff ff       	jmp    80105950 <alltraps>

80106746 <vector231>:
.globl vector231
vector231:
  pushl $0
80106746:	6a 00                	push   $0x0
  pushl $231
80106748:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
8010674d:	e9 fe f1 ff ff       	jmp    80105950 <alltraps>

80106752 <vector232>:
.globl vector232
vector232:
  pushl $0
80106752:	6a 00                	push   $0x0
  pushl $232
80106754:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106759:	e9 f2 f1 ff ff       	jmp    80105950 <alltraps>

8010675e <vector233>:
.globl vector233
vector233:
  pushl $0
8010675e:	6a 00                	push   $0x0
  pushl $233
80106760:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106765:	e9 e6 f1 ff ff       	jmp    80105950 <alltraps>

8010676a <vector234>:
.globl vector234
vector234:
  pushl $0
8010676a:	6a 00                	push   $0x0
  pushl $234
8010676c:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106771:	e9 da f1 ff ff       	jmp    80105950 <alltraps>

80106776 <vector235>:
.globl vector235
vector235:
  pushl $0
80106776:	6a 00                	push   $0x0
  pushl $235
80106778:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
8010677d:	e9 ce f1 ff ff       	jmp    80105950 <alltraps>

80106782 <vector236>:
.globl vector236
vector236:
  pushl $0
80106782:	6a 00                	push   $0x0
  pushl $236
80106784:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106789:	e9 c2 f1 ff ff       	jmp    80105950 <alltraps>

8010678e <vector237>:
.globl vector237
vector237:
  pushl $0
8010678e:	6a 00                	push   $0x0
  pushl $237
80106790:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106795:	e9 b6 f1 ff ff       	jmp    80105950 <alltraps>

8010679a <vector238>:
.globl vector238
vector238:
  pushl $0
8010679a:	6a 00                	push   $0x0
  pushl $238
8010679c:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801067a1:	e9 aa f1 ff ff       	jmp    80105950 <alltraps>

801067a6 <vector239>:
.globl vector239
vector239:
  pushl $0
801067a6:	6a 00                	push   $0x0
  pushl $239
801067a8:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801067ad:	e9 9e f1 ff ff       	jmp    80105950 <alltraps>

801067b2 <vector240>:
.globl vector240
vector240:
  pushl $0
801067b2:	6a 00                	push   $0x0
  pushl $240
801067b4:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801067b9:	e9 92 f1 ff ff       	jmp    80105950 <alltraps>

801067be <vector241>:
.globl vector241
vector241:
  pushl $0
801067be:	6a 00                	push   $0x0
  pushl $241
801067c0:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801067c5:	e9 86 f1 ff ff       	jmp    80105950 <alltraps>

801067ca <vector242>:
.globl vector242
vector242:
  pushl $0
801067ca:	6a 00                	push   $0x0
  pushl $242
801067cc:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801067d1:	e9 7a f1 ff ff       	jmp    80105950 <alltraps>

801067d6 <vector243>:
.globl vector243
vector243:
  pushl $0
801067d6:	6a 00                	push   $0x0
  pushl $243
801067d8:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801067dd:	e9 6e f1 ff ff       	jmp    80105950 <alltraps>

801067e2 <vector244>:
.globl vector244
vector244:
  pushl $0
801067e2:	6a 00                	push   $0x0
  pushl $244
801067e4:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801067e9:	e9 62 f1 ff ff       	jmp    80105950 <alltraps>

801067ee <vector245>:
.globl vector245
vector245:
  pushl $0
801067ee:	6a 00                	push   $0x0
  pushl $245
801067f0:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801067f5:	e9 56 f1 ff ff       	jmp    80105950 <alltraps>

801067fa <vector246>:
.globl vector246
vector246:
  pushl $0
801067fa:	6a 00                	push   $0x0
  pushl $246
801067fc:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106801:	e9 4a f1 ff ff       	jmp    80105950 <alltraps>

80106806 <vector247>:
.globl vector247
vector247:
  pushl $0
80106806:	6a 00                	push   $0x0
  pushl $247
80106808:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
8010680d:	e9 3e f1 ff ff       	jmp    80105950 <alltraps>

80106812 <vector248>:
.globl vector248
vector248:
  pushl $0
80106812:	6a 00                	push   $0x0
  pushl $248
80106814:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106819:	e9 32 f1 ff ff       	jmp    80105950 <alltraps>

8010681e <vector249>:
.globl vector249
vector249:
  pushl $0
8010681e:	6a 00                	push   $0x0
  pushl $249
80106820:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106825:	e9 26 f1 ff ff       	jmp    80105950 <alltraps>

8010682a <vector250>:
.globl vector250
vector250:
  pushl $0
8010682a:	6a 00                	push   $0x0
  pushl $250
8010682c:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106831:	e9 1a f1 ff ff       	jmp    80105950 <alltraps>

80106836 <vector251>:
.globl vector251
vector251:
  pushl $0
80106836:	6a 00                	push   $0x0
  pushl $251
80106838:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
8010683d:	e9 0e f1 ff ff       	jmp    80105950 <alltraps>

80106842 <vector252>:
.globl vector252
vector252:
  pushl $0
80106842:	6a 00                	push   $0x0
  pushl $252
80106844:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106849:	e9 02 f1 ff ff       	jmp    80105950 <alltraps>

8010684e <vector253>:
.globl vector253
vector253:
  pushl $0
8010684e:	6a 00                	push   $0x0
  pushl $253
80106850:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106855:	e9 f6 f0 ff ff       	jmp    80105950 <alltraps>

8010685a <vector254>:
.globl vector254
vector254:
  pushl $0
8010685a:	6a 00                	push   $0x0
  pushl $254
8010685c:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106861:	e9 ea f0 ff ff       	jmp    80105950 <alltraps>

80106866 <vector255>:
.globl vector255
vector255:
  pushl $0
80106866:	6a 00                	push   $0x0
  pushl $255
80106868:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
8010686d:	e9 de f0 ff ff       	jmp    80105950 <alltraps>
	...

80106880 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106880:	a1 24 57 11 80       	mov    0x80115724,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106885:	55                   	push   %ebp
80106886:	89 e5                	mov    %esp,%ebp
80106888:	2d 00 00 00 80       	sub    $0x80000000,%eax
8010688d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106890:	5d                   	pop    %ebp
80106891:	c3                   	ret    
80106892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068a0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068a0:	55                   	push   %ebp
801068a1:	89 e5                	mov    %esp,%ebp
801068a3:	83 ec 28             	sub    $0x28,%esp
801068a6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801068a9:	89 d3                	mov    %edx,%ebx
801068ab:	c1 eb 16             	shr    $0x16,%ebx
801068ae:	8d 1c 98             	lea    (%eax,%ebx,4),%ebx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068b1:	89 75 fc             	mov    %esi,-0x4(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
801068b4:	8b 33                	mov    (%ebx),%esi
801068b6:	f7 c6 01 00 00 00    	test   $0x1,%esi
801068bc:	74 22                	je     801068e0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801068be:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
801068c4:	81 ee 00 00 00 80    	sub    $0x80000000,%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801068ca:	c1 ea 0a             	shr    $0xa,%edx
801068cd:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801068d3:	8d 04 16             	lea    (%esi,%edx,1),%eax
}
801068d6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801068d9:	8b 75 fc             	mov    -0x4(%ebp),%esi
801068dc:	89 ec                	mov    %ebp,%esp
801068de:	5d                   	pop    %ebp
801068df:	c3                   	ret    

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801068e0:	85 c9                	test   %ecx,%ecx
801068e2:	75 04                	jne    801068e8 <walkpgdir+0x48>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801068e4:	31 c0                	xor    %eax,%eax
801068e6:	eb ee                	jmp    801068d6 <walkpgdir+0x36>

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801068e8:	89 55 f4             	mov    %edx,-0xc(%ebp)
801068eb:	e8 70 ba ff ff       	call   80102360 <kalloc>
801068f0:	85 c0                	test   %eax,%eax
801068f2:	89 c6                	mov    %eax,%esi
801068f4:	74 ee                	je     801068e4 <walkpgdir+0x44>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
801068f6:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801068fd:	00 
801068fe:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106905:	00 
80106906:	89 04 24             	mov    %eax,(%esp)
80106909:	e8 22 dd ff ff       	call   80104630 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010690e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106914:	83 c8 07             	or     $0x7,%eax
80106917:	89 03                	mov    %eax,(%ebx)
80106919:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010691c:	eb ac                	jmp    801068ca <walkpgdir+0x2a>
8010691e:	66 90                	xchg   %ax,%ax

80106920 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106920:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106921:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106923:	89 e5                	mov    %esp,%ebp
80106925:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106928:	8b 55 0c             	mov    0xc(%ebp),%edx
8010692b:	8b 45 08             	mov    0x8(%ebp),%eax
8010692e:	e8 6d ff ff ff       	call   801068a0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106933:	8b 00                	mov    (%eax),%eax
80106935:	a8 01                	test   $0x1,%al
80106937:	75 07                	jne    80106940 <uva2ka+0x20>
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106939:	31 c0                	xor    %eax,%eax
}
8010693b:	c9                   	leave  
8010693c:	c3                   	ret    
8010693d:	8d 76 00             	lea    0x0(%esi),%esi
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
80106940:	a8 04                	test   $0x4,%al
80106942:	74 f5                	je     80106939 <uva2ka+0x19>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106944:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106949:	2d 00 00 00 80       	sub    $0x80000000,%eax
}
8010694e:	c9                   	leave  
8010694f:	c3                   	ret    

80106950 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106950:	55                   	push   %ebp
80106951:	89 e5                	mov    %esp,%ebp
80106953:	57                   	push   %edi
80106954:	56                   	push   %esi
80106955:	53                   	push   %ebx
80106956:	83 ec 2c             	sub    $0x2c,%esp
80106959:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010695c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010695f:	85 db                	test   %ebx,%ebx
80106961:	74 75                	je     801069d8 <copyout+0x88>
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80106963:	8b 45 10             	mov    0x10(%ebp),%eax
80106966:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106969:	eb 39                	jmp    801069a4 <copyout+0x54>
8010696b:	90                   	nop
8010696c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106970:	89 f7                	mov    %esi,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106972:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106975:	29 d7                	sub    %edx,%edi
80106977:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010697d:	39 df                	cmp    %ebx,%edi
8010697f:	0f 47 fb             	cmova  %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106982:	29 f2                	sub    %esi,%edx
80106984:	8d 14 10             	lea    (%eax,%edx,1),%edx
80106987:	89 7c 24 08          	mov    %edi,0x8(%esp)
8010698b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
8010698f:	89 14 24             	mov    %edx,(%esp)
80106992:	e8 69 dd ff ff       	call   80104700 <memmove>
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106997:	29 fb                	sub    %edi,%ebx
80106999:	74 3d                	je     801069d8 <copyout+0x88>
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
8010699b:	01 7d e4             	add    %edi,-0x1c(%ebp)
    va = va0 + PGSIZE;
8010699e:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
801069a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
801069a7:	89 d6                	mov    %edx,%esi
801069a9:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801069af:	89 55 e0             	mov    %edx,-0x20(%ebp)
801069b2:	89 74 24 04          	mov    %esi,0x4(%esp)
801069b6:	89 0c 24             	mov    %ecx,(%esp)
801069b9:	e8 62 ff ff ff       	call   80106920 <uva2ka>
    if(pa0 == 0)
801069be:	8b 55 e0             	mov    -0x20(%ebp),%edx
801069c1:	85 c0                	test   %eax,%eax
801069c3:	75 ab                	jne    80106970 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801069c5:	83 c4 2c             	add    $0x2c,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801069c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
801069cd:	5b                   	pop    %ebx
801069ce:	5e                   	pop    %esi
801069cf:	5f                   	pop    %edi
801069d0:	5d                   	pop    %ebp
801069d1:	c3                   	ret    
801069d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801069d8:	83 c4 2c             	add    $0x2c,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801069db:	31 c0                	xor    %eax,%eax
  }
  return 0;
}
801069dd:	5b                   	pop    %ebx
801069de:	5e                   	pop    %esi
801069df:	5f                   	pop    %edi
801069e0:	5d                   	pop    %ebp
801069e1:	c3                   	ret    
801069e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069f0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801069f0:	55                   	push   %ebp
801069f1:	89 e5                	mov    %esp,%ebp
801069f3:	57                   	push   %edi
801069f4:	56                   	push   %esi
801069f5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801069f6:	89 d3                	mov    %edx,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801069f8:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801069fc:	83 ec 2c             	sub    $0x2c,%esp
801069ff:	8b 75 08             	mov    0x8(%ebp),%esi
80106a02:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106a05:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a0b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a11:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
80106a15:	eb 1d                	jmp    80106a34 <mappages+0x44>
80106a17:	90                   	nop
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106a18:	f6 00 01             	testb  $0x1,(%eax)
80106a1b:	75 45                	jne    80106a62 <mappages+0x72>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a1d:	8b 55 0c             	mov    0xc(%ebp),%edx
80106a20:	09 f2                	or     %esi,%edx
    if(a == last)
80106a22:	39 fb                	cmp    %edi,%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a24:	89 10                	mov    %edx,(%eax)
    if(a == last)
80106a26:	74 30                	je     80106a58 <mappages+0x68>
      break;
    a += PGSIZE;
80106a28:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    pa += PGSIZE;
80106a2e:	81 c6 00 10 00 00    	add    $0x1000,%esi
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106a34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a37:	b9 01 00 00 00       	mov    $0x1,%ecx
80106a3c:	89 da                	mov    %ebx,%edx
80106a3e:	e8 5d fe ff ff       	call   801068a0 <walkpgdir>
80106a43:	85 c0                	test   %eax,%eax
80106a45:	75 d1                	jne    80106a18 <mappages+0x28>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106a47:	83 c4 2c             	add    $0x2c,%esp
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
80106a4a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return 0;
}
80106a4f:	5b                   	pop    %ebx
80106a50:	5e                   	pop    %esi
80106a51:	5f                   	pop    %edi
80106a52:	5d                   	pop    %ebp
80106a53:	c3                   	ret    
80106a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106a58:	83 c4 2c             	add    $0x2c,%esp
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
80106a5b:	31 c0                	xor    %eax,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106a5d:	5b                   	pop    %ebx
80106a5e:	5e                   	pop    %esi
80106a5f:	5f                   	pop    %edi
80106a60:	5d                   	pop    %ebp
80106a61:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106a62:	c7 04 24 58 7a 10 80 	movl   $0x80107a58,(%esp)
80106a69:	e8 62 99 ff ff       	call   801003d0 <panic>
80106a6e:	66 90                	xchg   %ax,%ax

80106a70 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106a70:	55                   	push   %ebp
80106a71:	89 e5                	mov    %esp,%ebp
80106a73:	56                   	push   %esi
80106a74:	53                   	push   %ebx
80106a75:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106a78:	e8 e3 b8 ff ff       	call   80102360 <kalloc>
80106a7d:	85 c0                	test   %eax,%eax
80106a7f:	89 c6                	mov    %eax,%esi
80106a81:	74 53                	je     80106ad6 <setupkvm+0x66>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106a83:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106a8a:	00 
80106a8b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106a92:	00 
80106a93:	89 04 24             	mov    %eax,(%esp)
80106a96:	e8 95 db ff ff       	call   80104630 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106a9b:	b8 60 a4 10 80       	mov    $0x8010a460,%eax
80106aa0:	3d 20 a4 10 80       	cmp    $0x8010a420,%eax
80106aa5:	76 2f                	jbe    80106ad6 <setupkvm+0x66>
 { (void*)DEVSPACE, DEVSPACE,      0,         PTE_W}, // more devices
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
80106aa7:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106aac:	8b 53 0c             	mov    0xc(%ebx),%edx
80106aaf:	8b 43 04             	mov    0x4(%ebx),%eax
80106ab2:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106ab5:	89 54 24 04          	mov    %edx,0x4(%esp)
80106ab9:	8b 13                	mov    (%ebx),%edx
80106abb:	89 04 24             	mov    %eax,(%esp)
80106abe:	29 c1                	sub    %eax,%ecx
80106ac0:	89 f0                	mov    %esi,%eax
80106ac2:	e8 29 ff ff ff       	call   801069f0 <mappages>
80106ac7:	85 c0                	test   %eax,%eax
80106ac9:	78 15                	js     80106ae0 <setupkvm+0x70>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106acb:	83 c3 10             	add    $0x10,%ebx
80106ace:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106ad4:	75 d6                	jne    80106aac <setupkvm+0x3c>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106ad6:	83 c4 10             	add    $0x10,%esp
80106ad9:	89 f0                	mov    %esi,%eax
80106adb:	5b                   	pop    %ebx
80106adc:	5e                   	pop    %esi
80106add:	5d                   	pop    %ebp
80106ade:	c3                   	ret    
80106adf:	90                   	nop
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106ae0:	31 f6                	xor    %esi,%esi
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106ae2:	83 c4 10             	add    $0x10,%esp
80106ae5:	89 f0                	mov    %esi,%eax
80106ae7:	5b                   	pop    %ebx
80106ae8:	5e                   	pop    %esi
80106ae9:	5d                   	pop    %ebp
80106aea:	c3                   	ret    
80106aeb:	90                   	nop
80106aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106af0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106af0:	55                   	push   %ebp
80106af1:	89 e5                	mov    %esp,%ebp
80106af3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106af6:	e8 75 ff ff ff       	call   80106a70 <setupkvm>
80106afb:	a3 24 57 11 80       	mov    %eax,0x80115724
80106b00:	2d 00 00 00 80       	sub    $0x80000000,%eax
80106b05:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106b08:	c9                   	leave  
80106b09:	c3                   	ret    
80106b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106b10 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106b10:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106b11:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106b13:	89 e5                	mov    %esp,%ebp
80106b15:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106b18:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b1b:	8b 45 08             	mov    0x8(%ebp),%eax
80106b1e:	e8 7d fd ff ff       	call   801068a0 <walkpgdir>
  if(pte == 0)
80106b23:	85 c0                	test   %eax,%eax
80106b25:	74 05                	je     80106b2c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106b27:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106b2a:	c9                   	leave  
80106b2b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106b2c:	c7 04 24 5e 7a 10 80 	movl   $0x80107a5e,(%esp)
80106b33:	e8 98 98 ff ff       	call   801003d0 <panic>
80106b38:	90                   	nop
80106b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b40 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	83 ec 38             	sub    $0x38,%esp
80106b46:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106b49:	8b 75 10             	mov    0x10(%ebp),%esi
80106b4c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b4f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80106b52:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106b55:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106b58:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106b5e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106b61:	77 59                	ja     80106bbc <inituvm+0x7c>
    panic("inituvm: more than a page");
  mem = kalloc();
80106b63:	e8 f8 b7 ff ff       	call   80102360 <kalloc>
  memset(mem, 0, PGSIZE);
80106b68:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106b6f:	00 
80106b70:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106b77:	00 
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106b78:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106b7a:	89 04 24             	mov    %eax,(%esp)
80106b7d:	e8 ae da ff ff       	call   80104630 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106b82:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b88:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b8d:	89 04 24             	mov    %eax,(%esp)
80106b90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b93:	31 d2                	xor    %edx,%edx
80106b95:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106b9c:	00 
80106b9d:	e8 4e fe ff ff       	call   801069f0 <mappages>
  memmove(mem, init, sz);
80106ba2:	89 75 10             	mov    %esi,0x10(%ebp)
}
80106ba5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106ba8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
80106bab:	8b 7d fc             	mov    -0x4(%ebp),%edi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106bae:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106bb1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106bb4:	89 ec                	mov    %ebp,%esp
80106bb6:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106bb7:	e9 44 db ff ff       	jmp    80104700 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106bbc:	c7 04 24 68 7a 10 80 	movl   $0x80107a68,(%esp)
80106bc3:	e8 08 98 ff ff       	call   801003d0 <panic>
80106bc8:	90                   	nop
80106bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106bd0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	57                   	push   %edi
80106bd4:	56                   	push   %esi
80106bd5:	53                   	push   %ebx
80106bd6:	83 ec 2c             	sub    $0x2c,%esp
80106bd9:	8b 75 0c             	mov    0xc(%ebp),%esi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106bdc:	39 75 10             	cmp    %esi,0x10(%ebp)
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106bdf:	8b 7d 08             	mov    0x8(%ebp),%edi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;
80106be2:	89 f0                	mov    %esi,%eax
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106be4:	73 75                	jae    80106c5b <deallocuvm+0x8b>
    return oldsz;

  a = PGROUNDUP(newsz);
80106be6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80106be9:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
80106bef:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106bf5:	39 de                	cmp    %ebx,%esi
80106bf7:	77 3a                	ja     80106c33 <deallocuvm+0x63>
80106bf9:	eb 5d                	jmp    80106c58 <deallocuvm+0x88>
80106bfb:	90                   	nop
80106bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106c00:	8b 10                	mov    (%eax),%edx
80106c02:	f6 c2 01             	test   $0x1,%dl
80106c05:	74 22                	je     80106c29 <deallocuvm+0x59>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106c07:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106c0d:	74 54                	je     80106c63 <deallocuvm+0x93>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106c0f:	81 ea 00 00 00 80    	sub    $0x80000000,%edx
80106c15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c18:	89 14 24             	mov    %edx,(%esp)
80106c1b:	e8 90 b7 ff ff       	call   801023b0 <kfree>
      *pte = 0;
80106c20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c23:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106c29:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c2f:	39 de                	cmp    %ebx,%esi
80106c31:	76 25                	jbe    80106c58 <deallocuvm+0x88>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106c33:	31 c9                	xor    %ecx,%ecx
80106c35:	89 da                	mov    %ebx,%edx
80106c37:	89 f8                	mov    %edi,%eax
80106c39:	e8 62 fc ff ff       	call   801068a0 <walkpgdir>
    if(!pte)
80106c3e:	85 c0                	test   %eax,%eax
80106c40:	75 be                	jne    80106c00 <deallocuvm+0x30>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106c42:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106c48:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106c4e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c54:	39 de                	cmp    %ebx,%esi
80106c56:	77 db                	ja     80106c33 <deallocuvm+0x63>
      char *v = P2V(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80106c58:	8b 45 10             	mov    0x10(%ebp),%eax
}
80106c5b:	83 c4 2c             	add    $0x2c,%esp
80106c5e:	5b                   	pop    %ebx
80106c5f:	5e                   	pop    %esi
80106c60:	5f                   	pop    %edi
80106c61:	5d                   	pop    %ebp
80106c62:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106c63:	c7 04 24 12 74 10 80 	movl   $0x80107412,(%esp)
80106c6a:	e8 61 97 ff ff       	call   801003d0 <panic>
80106c6f:	90                   	nop

80106c70 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106c70:	55                   	push   %ebp
80106c71:	89 e5                	mov    %esp,%ebp
80106c73:	56                   	push   %esi
80106c74:	53                   	push   %ebx
80106c75:	83 ec 10             	sub    $0x10,%esp
80106c78:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint i;

  if(pgdir == 0)
80106c7b:	85 db                	test   %ebx,%ebx
80106c7d:	74 5e                	je     80106cdd <freevm+0x6d>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80106c7f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80106c86:	00 
80106c87:	31 f6                	xor    %esi,%esi
80106c89:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
80106c90:	80 
80106c91:	89 1c 24             	mov    %ebx,(%esp)
80106c94:	e8 37 ff ff ff       	call   80106bd0 <deallocuvm>
80106c99:	eb 10                	jmp    80106cab <freevm+0x3b>
80106c9b:	90                   	nop
80106c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < NPDENTRIES; i++){
80106ca0:	83 c6 01             	add    $0x1,%esi
80106ca3:	81 fe 00 04 00 00    	cmp    $0x400,%esi
80106ca9:	74 24                	je     80106ccf <freevm+0x5f>
    if(pgdir[i] & PTE_P){
80106cab:	8b 04 b3             	mov    (%ebx,%esi,4),%eax
80106cae:	a8 01                	test   $0x1,%al
80106cb0:	74 ee                	je     80106ca0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106cb2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106cb7:	83 c6 01             	add    $0x1,%esi
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106cba:	2d 00 00 00 80       	sub    $0x80000000,%eax
80106cbf:	89 04 24             	mov    %eax,(%esp)
80106cc2:	e8 e9 b6 ff ff       	call   801023b0 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106cc7:	81 fe 00 04 00 00    	cmp    $0x400,%esi
80106ccd:	75 dc                	jne    80106cab <freevm+0x3b>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106ccf:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106cd2:	83 c4 10             	add    $0x10,%esp
80106cd5:	5b                   	pop    %ebx
80106cd6:	5e                   	pop    %esi
80106cd7:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106cd8:	e9 d3 b6 ff ff       	jmp    801023b0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106cdd:	c7 04 24 82 7a 10 80 	movl   $0x80107a82,(%esp)
80106ce4:	e8 e7 96 ff ff       	call   801003d0 <panic>
80106ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106cf0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	57                   	push   %edi
80106cf4:	56                   	push   %esi
80106cf5:	53                   	push   %ebx
80106cf6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106cf9:	e8 72 fd ff ff       	call   80106a70 <setupkvm>
80106cfe:	85 c0                	test   %eax,%eax
80106d00:	89 c6                	mov    %eax,%esi
80106d02:	0f 84 91 00 00 00    	je     80106d99 <copyuvm+0xa9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106d08:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d0b:	85 c0                	test   %eax,%eax
80106d0d:	0f 84 86 00 00 00    	je     80106d99 <copyuvm+0xa9>
80106d13:	31 db                	xor    %ebx,%ebx
80106d15:	eb 54                	jmp    80106d6b <copyuvm+0x7b>
80106d17:	90                   	nop
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106d18:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d1b:	89 3c 24             	mov    %edi,(%esp)
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106d1e:	81 ef 00 00 00 80    	sub    $0x80000000,%edi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106d24:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106d2b:	00 
80106d2c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d31:	2d 00 00 00 80       	sub    $0x80000000,%eax
80106d36:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d3a:	e8 c1 d9 ff ff       	call   80104700 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106d3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d42:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d47:	89 da                	mov    %ebx,%edx
80106d49:	89 3c 24             	mov    %edi,(%esp)
80106d4c:	25 ff 0f 00 00       	and    $0xfff,%eax
80106d51:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d55:	89 f0                	mov    %esi,%eax
80106d57:	e8 94 fc ff ff       	call   801069f0 <mappages>
80106d5c:	85 c0                	test   %eax,%eax
80106d5e:	78 2f                	js     80106d8f <copyuvm+0x9f>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106d60:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d66:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80106d69:	76 2e                	jbe    80106d99 <copyuvm+0xa9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106d6b:	8b 45 08             	mov    0x8(%ebp),%eax
80106d6e:	31 c9                	xor    %ecx,%ecx
80106d70:	89 da                	mov    %ebx,%edx
80106d72:	e8 29 fb ff ff       	call   801068a0 <walkpgdir>
80106d77:	85 c0                	test   %eax,%eax
80106d79:	74 28                	je     80106da3 <copyuvm+0xb3>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106d7b:	8b 00                	mov    (%eax),%eax
80106d7d:	a8 01                	test   $0x1,%al
80106d7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d82:	74 2b                	je     80106daf <copyuvm+0xbf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80106d84:	e8 d7 b5 ff ff       	call   80102360 <kalloc>
80106d89:	85 c0                	test   %eax,%eax
80106d8b:	89 c7                	mov    %eax,%edi
80106d8d:	75 89                	jne    80106d18 <copyuvm+0x28>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80106d8f:	89 34 24             	mov    %esi,(%esp)
80106d92:	31 f6                	xor    %esi,%esi
80106d94:	e8 d7 fe ff ff       	call   80106c70 <freevm>
  return 0;
}
80106d99:	83 c4 2c             	add    $0x2c,%esp
80106d9c:	89 f0                	mov    %esi,%eax
80106d9e:	5b                   	pop    %ebx
80106d9f:	5e                   	pop    %esi
80106da0:	5f                   	pop    %edi
80106da1:	5d                   	pop    %ebp
80106da2:	c3                   	ret    

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106da3:	c7 04 24 93 7a 10 80 	movl   $0x80107a93,(%esp)
80106daa:	e8 21 96 ff ff       	call   801003d0 <panic>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106daf:	c7 04 24 ad 7a 10 80 	movl   $0x80107aad,(%esp)
80106db6:	e8 15 96 ff ff       	call   801003d0 <panic>
80106dbb:	90                   	nop
80106dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106dc0 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106dc0:	55                   	push   %ebp
80106dc1:	89 e5                	mov    %esp,%ebp
80106dc3:	57                   	push   %edi
80106dc4:	56                   	push   %esi
80106dc5:	53                   	push   %ebx
80106dc6:	83 ec 2c             	sub    $0x2c,%esp
80106dc9:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106dcc:	85 ff                	test   %edi,%edi
80106dce:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106dd1:	0f 88 9c 00 00 00    	js     80106e73 <allocuvm+0xb3>
    return 0;
  if(newsz < oldsz)
80106dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
80106dda:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
80106ddd:	0f 82 a5 00 00 00    	jb     80106e88 <allocuvm+0xc8>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106de3:	8b 75 0c             	mov    0xc(%ebp),%esi
80106de6:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80106dec:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106df2:	39 f7                	cmp    %esi,%edi
80106df4:	77 50                	ja     80106e46 <allocuvm+0x86>
80106df6:	e9 90 00 00 00       	jmp    80106e8b <allocuvm+0xcb>
80106dfb:	90                   	nop
80106dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106e00:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106e07:	00 
80106e08:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106e0f:	00 
80106e10:	89 04 24             	mov    %eax,(%esp)
80106e13:	e8 18 d8 ff ff       	call   80104630 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e18:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e1e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e23:	89 04 24             	mov    %eax,(%esp)
80106e26:	8b 45 08             	mov    0x8(%ebp),%eax
80106e29:	89 f2                	mov    %esi,%edx
80106e2b:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106e32:	00 
80106e33:	e8 b8 fb ff ff       	call   801069f0 <mappages>
80106e38:	85 c0                	test   %eax,%eax
80106e3a:	78 5c                	js     80106e98 <allocuvm+0xd8>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e3c:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106e42:	39 f7                	cmp    %esi,%edi
80106e44:	76 45                	jbe    80106e8b <allocuvm+0xcb>
    mem = kalloc();
80106e46:	e8 15 b5 ff ff       	call   80102360 <kalloc>
    if(mem == 0){
80106e4b:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106e4d:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106e4f:	75 af                	jne    80106e00 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106e51:	c7 04 24 c7 7a 10 80 	movl   $0x80107ac7,(%esp)
80106e58:	e8 13 9a ff ff       	call   80100870 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e60:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106e64:	89 44 24 08          	mov    %eax,0x8(%esp)
80106e68:	8b 45 08             	mov    0x8(%ebp),%eax
80106e6b:	89 04 24             	mov    %eax,(%esp)
80106e6e:	e8 5d fd ff ff       	call   80106bd0 <deallocuvm>
80106e73:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e7a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e7d:	83 c4 2c             	add    $0x2c,%esp
80106e80:	5b                   	pop    %ebx
80106e81:	5e                   	pop    %esi
80106e82:	5f                   	pop    %edi
80106e83:	5d                   	pop    %ebp
80106e84:	c3                   	ret    
80106e85:	8d 76 00             	lea    0x0(%esi),%esi
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
    return oldsz;
80106e88:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e8b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e8e:	83 c4 2c             	add    $0x2c,%esp
80106e91:	5b                   	pop    %ebx
80106e92:	5e                   	pop    %esi
80106e93:	5f                   	pop    %edi
80106e94:	5d                   	pop    %ebp
80106e95:	c3                   	ret    
80106e96:	66 90                	xchg   %ax,%ax
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106e98:	c7 04 24 df 7a 10 80 	movl   $0x80107adf,(%esp)
80106e9f:	e8 cc 99 ff ff       	call   80100870 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ea7:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106eab:	89 44 24 08          	mov    %eax,0x8(%esp)
80106eaf:	8b 45 08             	mov    0x8(%ebp),%eax
80106eb2:	89 04 24             	mov    %eax,(%esp)
80106eb5:	e8 16 fd ff ff       	call   80106bd0 <deallocuvm>
      kfree(mem);
80106eba:	89 1c 24             	mov    %ebx,(%esp)
80106ebd:	e8 ee b4 ff ff       	call   801023b0 <kfree>
80106ec2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      return 0;
    }
  }
  return newsz;
}
80106ec9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ecc:	83 c4 2c             	add    $0x2c,%esp
80106ecf:	5b                   	pop    %ebx
80106ed0:	5e                   	pop    %esi
80106ed1:	5f                   	pop    %edi
80106ed2:	5d                   	pop    %ebp
80106ed3:	c3                   	ret    
80106ed4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ee0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	57                   	push   %edi
80106ee4:	56                   	push   %esi
80106ee5:	53                   	push   %ebx
80106ee6:	83 ec 2c             	sub    $0x2c,%esp
80106ee9:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106eec:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
80106ef2:	0f 85 96 00 00 00    	jne    80106f8e <loaduvm+0xae>
    panic("loaduvm: addr must be page aligned");
80106ef8:	8b 75 18             	mov    0x18(%ebp),%esi
80106efb:	31 db                	xor    %ebx,%ebx
  for(i = 0; i < sz; i += PGSIZE){
80106efd:	85 f6                	test   %esi,%esi
80106eff:	75 18                	jne    80106f19 <loaduvm+0x39>
80106f01:	eb 75                	jmp    80106f78 <loaduvm+0x98>
80106f03:	90                   	nop
80106f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f08:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f0e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106f14:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106f17:	76 5f                	jbe    80106f78 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106f19:	8b 45 08             	mov    0x8(%ebp),%eax
80106f1c:	31 c9                	xor    %ecx,%ecx
80106f1e:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
80106f21:	e8 7a f9 ff ff       	call   801068a0 <walkpgdir>
80106f26:	85 c0                	test   %eax,%eax
80106f28:	74 58                	je     80106f82 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106f2a:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
80106f2c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
80106f32:	ba 00 10 00 00       	mov    $0x1000,%edx
80106f37:	0f 42 d6             	cmovb  %esi,%edx
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f3a:	8b 4d 14             	mov    0x14(%ebp),%ecx
80106f3d:	89 54 24 0c          	mov    %edx,0xc(%esp)
80106f41:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106f44:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f49:	2d 00 00 00 80       	sub    $0x80000000,%eax
80106f4e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f52:	8b 45 10             	mov    0x10(%ebp),%eax
80106f55:	8d 0c 0b             	lea    (%ebx,%ecx,1),%ecx
80106f58:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106f5c:	89 04 24             	mov    %eax,(%esp)
80106f5f:	e8 0c a9 ff ff       	call   80101870 <readi>
80106f64:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106f67:	39 d0                	cmp    %edx,%eax
80106f69:	74 9d                	je     80106f08 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106f6b:	83 c4 2c             	add    $0x2c,%esp
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return -1;
  }
  return 0;
}
80106f73:	5b                   	pop    %ebx
80106f74:	5e                   	pop    %esi
80106f75:	5f                   	pop    %edi
80106f76:	5d                   	pop    %ebp
80106f77:	c3                   	ret    
80106f78:	83 c4 2c             	add    $0x2c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106f7b:	31 c0                	xor    %eax,%eax
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
}
80106f7d:	5b                   	pop    %ebx
80106f7e:	5e                   	pop    %esi
80106f7f:	5f                   	pop    %edi
80106f80:	5d                   	pop    %ebp
80106f81:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106f82:	c7 04 24 fb 7a 10 80 	movl   $0x80107afb,(%esp)
80106f89:	e8 42 94 ff ff       	call   801003d0 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106f8e:	c7 04 24 58 7b 10 80 	movl   $0x80107b58,(%esp)
80106f95:	e8 36 94 ff ff       	call   801003d0 <panic>
80106f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fa0 <switchuvm>:
}

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106fa0:	55                   	push   %ebp
80106fa1:	89 e5                	mov    %esp,%ebp
80106fa3:	53                   	push   %ebx
80106fa4:	83 ec 14             	sub    $0x14,%esp
80106fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106faa:	85 db                	test   %ebx,%ebx
80106fac:	0f 84 aa 00 00 00    	je     8010705c <switchuvm+0xbc>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106fb2:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106fb5:	85 c9                	test   %ecx,%ecx
80106fb7:	0f 84 b7 00 00 00    	je     80107074 <switchuvm+0xd4>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106fbd:	8b 53 04             	mov    0x4(%ebx),%edx
80106fc0:	85 d2                	test   %edx,%edx
80106fc2:	0f 84 a0 00 00 00    	je     80107068 <switchuvm+0xc8>
    panic("switchuvm: no pgdir");

  pushcli();
80106fc8:	e8 d3 d4 ff ff       	call   801044a0 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106fcd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106fd3:	8d 50 08             	lea    0x8(%eax),%edx
80106fd6:	89 d1                	mov    %edx,%ecx
80106fd8:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106fdf:	c1 e9 10             	shr    $0x10,%ecx
80106fe2:	c1 ea 18             	shr    $0x18,%edx
80106fe5:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80106feb:	c6 80 a5 00 00 00 99 	movb   $0x99,0xa5(%eax)
80106ff2:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80106ff9:	67 00 
80106ffb:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
80107002:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107008:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010700e:	80 a0 a5 00 00 00 ef 	andb   $0xef,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107015:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010701b:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107021:	8b 53 08             	mov    0x8(%ebx),%edx
80107024:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010702a:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107030:	89 50 0c             	mov    %edx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
80107033:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107039:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
8010703f:	b8 30 00 00 00       	mov    $0x30,%eax
80107044:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107047:	8b 43 04             	mov    0x4(%ebx),%eax
8010704a:	2d 00 00 00 80       	sub    $0x80000000,%eax
8010704f:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80107052:	83 c4 14             	add    $0x14,%esp
80107055:	5b                   	pop    %ebx
80107056:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80107057:	e9 84 d4 ff ff       	jmp    801044e0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
8010705c:	c7 04 24 19 7b 10 80 	movl   $0x80107b19,(%esp)
80107063:	e8 68 93 ff ff       	call   801003d0 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80107068:	c7 04 24 44 7b 10 80 	movl   $0x80107b44,(%esp)
8010706f:	e8 5c 93 ff ff       	call   801003d0 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80107074:	c7 04 24 2f 7b 10 80 	movl   $0x80107b2f,(%esp)
8010707b:	e8 50 93 ff ff       	call   801003d0 <panic>

80107080 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107080:	55                   	push   %ebp
80107081:	89 e5                	mov    %esp,%ebp
80107083:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107086:	e8 95 b9 ff ff       	call   80102a20 <cpunum>
8010708b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107091:	05 a0 27 11 80       	add    $0x801127a0,%eax
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107096:	8d 90 b4 00 00 00    	lea    0xb4(%eax),%edx
8010709c:	66 89 90 8a 00 00 00 	mov    %dx,0x8a(%eax)
801070a3:	89 d1                	mov    %edx,%ecx
801070a5:	c1 ea 18             	shr    $0x18,%edx
801070a8:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)
801070ae:	c1 e9 10             	shr    $0x10,%ecx

  lgdt(c->gdt, sizeof(c->gdt));
801070b1:	8d 50 70             	lea    0x70(%eax),%edx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801070b4:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801070ba:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801070c0:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801070c4:	c6 40 7d 9a          	movb   $0x9a,0x7d(%eax)
801070c8:	c6 40 7e cf          	movb   $0xcf,0x7e(%eax)
801070cc:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801070d0:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801070d7:	ff ff 
801070d9:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801070e0:	00 00 
801070e2:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801070e9:	c6 80 85 00 00 00 92 	movb   $0x92,0x85(%eax)
801070f0:	c6 80 86 00 00 00 cf 	movb   $0xcf,0x86(%eax)
801070f7:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801070fe:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107105:	ff ff 
80107107:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
8010710e:	00 00 
80107110:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107117:	c6 80 95 00 00 00 fa 	movb   $0xfa,0x95(%eax)
8010711e:	c6 80 96 00 00 00 cf 	movb   $0xcf,0x96(%eax)
80107125:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010712c:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107133:	ff ff 
80107135:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
8010713c:	00 00 
8010713e:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107145:	c6 80 9d 00 00 00 f2 	movb   $0xf2,0x9d(%eax)
8010714c:	c6 80 9e 00 00 00 cf 	movb   $0xcf,0x9e(%eax)
80107153:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
8010715a:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107161:	00 00 
80107163:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
80107169:	c6 80 8d 00 00 00 92 	movb   $0x92,0x8d(%eax)
80107170:	c6 80 8e 00 00 00 c0 	movb   $0xc0,0x8e(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80107177:	66 c7 45 f2 37 00    	movw   $0x37,-0xe(%ebp)
  pd[1] = (uint)p;
8010717d:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107181:	c1 ea 10             	shr    $0x10,%edx
80107184:	66 89 55 f6          	mov    %dx,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107188:	8d 55 f2             	lea    -0xe(%ebp),%edx
8010718b:	0f 01 12             	lgdtl  (%edx)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
8010718e:	ba 18 00 00 00       	mov    $0x18,%edx
80107193:	8e ea                	mov    %edx,%gs

  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
80107195:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
8010719b:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801071a2:	00 00 00 00 
}
801071a6:	c9                   	leave  
801071a7:	c3                   	ret    
